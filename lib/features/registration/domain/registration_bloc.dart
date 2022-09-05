import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pt_tz/common/resources/widgets/errors/error_mapper.dart';
import 'package:pt_tz/common/resources/widgets/errors/error_type.dart';
import 'package:pt_tz/common/resources/widgets/errors/failure_model.dart';
import 'package:pt_tz/features/registration/domain/models/registration_bundle.dart';
import 'package:pt_tz/features/registration/domain/registration_states.dart';

part 'registration_bloc.freezed.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const RegistrationEvent._();

  const factory RegistrationEvent.setEmail({
    required String email,
  }) = SetEmailRegistrationEvent;

  const factory RegistrationEvent.setPass({
    required String pass,
    required String confirmPass,
  }) = SetPassRegistrationEvent;

  const factory RegistrationEvent.createUser() = CreateUserRegistrationEvent;
}

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = InitialRegistrationState;

  @Implements<SetEmailRegistrationState>()
  @Implements<PendingRegistrationState>()
  const factory RegistrationState.setEmailPending() =
      PendingSetEmailRegistrationState;

  @Implements<SetEmailRegistrationState>()
  @Implements<SuccessRegistrationState>()
  const factory RegistrationState.setEmailSuccess() =
      SuccessSetEmailRegistrationState;

  @Implements<SetEmailRegistrationState>()
  @Implements<FailureRegistrationState>()
  const factory RegistrationState.setEmailFailure({
    required Failure failure,
  }) = FailureSetEmailRegistrationState;

  @Implements<SetPassRegistrationState>()
  @Implements<PendingRegistrationState>()
  const factory RegistrationState.setPassPending() =
      PendingSetPassRegistrationState;

  @Implements<SetPassRegistrationState>()
  @Implements<SuccessRegistrationState>()
  const factory RegistrationState.setPassSuccess() =
      SuccessSetPassRegistrationState;

  @Implements<SetPassRegistrationState>()
  @Implements<FailureRegistrationState>()
  const factory RegistrationState.setPassFailure({
    required Failure failure,
  }) = FailureSetPassRegistrationState;

  @Implements<CreateUserRegistrationState>()
  @Implements<PendingRegistrationState>()
  const factory RegistrationState.createUserPending() =
      PendingCreateUserRegistrationState;

  @Implements<CreateUserRegistrationState>()
  @Implements<SuccessRegistrationState>()
  const factory RegistrationState.createUserSuccess() =
      SuccessCreateUserRegistrationState;

  @Implements<CreateUserRegistrationState>()
  @Implements<FailureRegistrationState>()
  const factory RegistrationState.createUserFailure({
    required Failure failure,
  }) = FailureCreateUserRegistrationState;

  const RegistrationState._();
}

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  static final RegistrationBundle _bundle = RegistrationBundle();
  final FirebaseAuth _auth;

  RegistrationBloc(this._auth)
      : super(
          const RegistrationState.initial(),
        ) {
    on<SetEmailRegistrationEvent>(_setEmail);
    on<SetPassRegistrationEvent>(_setPass);
    on<CreateUserRegistrationEvent>(_createUser);
  }

  Future<void> _setEmail(
    SetEmailRegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(const RegistrationState.setEmailPending());

    try {
      final methods = await _auth.fetchSignInMethodsForEmail(event.email);
      if (methods.isNotEmpty) {
        final failure = AuthFailure(
          type: AuthErrorType.invalidEmail,
          message: '',
        );
        emit(RegistrationState.setEmailFailure(failure: failure));
      } else {
        _bundle.email = event.email;
        emit(const RegistrationState.setEmailSuccess());
      }
    } on Exception catch (e) {
      final failure = ErrorMapper.map(e);
      emit(RegistrationState.setEmailFailure(failure: failure));
    }
  }

  Future<void> _setPass(
    SetPassRegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(const RegistrationState.setPassPending());
    if (event.pass == event.confirmPass && event.pass.length > 6) {
      _bundle.pass = event.pass;
      emit(const RegistrationState.setPassSuccess());
    } else {
      final failure = AuthFailure(
        type: AuthErrorType.invalidConfirmPassword,
        message: '',
      );
      emit(RegistrationState.setPassFailure(failure: failure));
    }
  }

  Future<void> _createUser(
    CreateUserRegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(const RegistrationState.createUserPending());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _bundle.email!,
        password: _bundle.pass!,
      );
      emit(const RegistrationState.createUserSuccess());
    } on Exception catch (e) {
      final failure = ErrorMapper.map(e);
      emit(RegistrationState.createUserFailure(failure: failure));
    }
  }
}
