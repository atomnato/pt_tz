import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pt_tz/common/resources/widgets/errors/error_mapper.dart';
import 'package:pt_tz/common/resources/widgets/errors/failure_model.dart';
import 'package:pt_tz/features/auth/domain/auth_states.dart';

part 'auth_bloc.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const AuthEvent._();

  const factory AuthEvent.loginWithEmail({
    required String email,
    required String pass,
  }) = LoginWithEmailAuthEvent;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = InitialAuthState;

  @Implements<LoginWithEmailAuthState>()
  @Implements<PendingAuthState>()
  const factory AuthState.loginWithEmailPending() =
      PendingLoginWithEmailAuthState;

  @Implements<LoginWithEmailAuthState>()
  @Implements<SuccessAuthState>()
  const factory AuthState.loginWithEmailSuccess() =
      SuccessLoginWithEmailAuthState;

  @Implements<LoginWithEmailAuthState>()
  @Implements<FailureAuthState>()
  const factory AuthState.loginWithEmailFailure({required Failure failure}) =
      FailureLoginWithEmailAuthState;

  const AuthState._();
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._auth) : super(const AuthState.initial()) {
    on<LoginWithEmailAuthEvent>(_loginWithEmail);
  }

  final FirebaseAuth _auth;

  Future<void> _loginWithEmail(
    LoginWithEmailAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loginWithEmailPending());
    try {
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.pass,
      );
      emit(const AuthState.loginWithEmailSuccess());
    } on Exception catch (e) {
      final failure = ErrorMapper.map(e);
      emit(FailureLoginWithEmailAuthState(failure: failure));
    }
  }
}
