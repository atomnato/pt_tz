import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pt_tz/features/app/domain/launcher_states.dart';

part 'launcher_bloc.freezed.dart';

@freezed
class LauncherEvent with _$LauncherEvent {
  const LauncherEvent._();

  const factory LauncherEvent.singIn({
    User? user,
  }) = SignInLauncherEvent;

  const factory LauncherEvent.signOut({
    User? user,
  }) = SignOutLauncherEvent;
}

@freezed
class LauncherState with _$LauncherState {
  const factory LauncherState.initial() = InitialLauncherState;

  @Implements<SignInLauncherState>()
  @Implements<PendingLauncherState>()
  const factory LauncherState.authenticatePending() =
      PendingAuthenticateLauncherState;

  @Implements<SignInLauncherState>()
  @Implements<SuccessLauncherState>()
  const factory LauncherState.authenticateSuccess() =
      SuccessAuthenticateLauncherState;

  @Implements<SignInLauncherState>()
  @Implements<FailureLauncherState>()
  const factory LauncherState.authenticateFailure({required Type typeError}) =
      FailureAuthenticateLauncherState;

  @Implements<SignOutLauncherState>()
  @Implements<PendingLauncherState>()
  const factory LauncherState.logoutPending() =
  PendingLogoutLauncherState;

  @Implements<SignOutLauncherState>()
  @Implements<SuccessLauncherState>()
  const factory LauncherState.logoutSuccess() =
  SuccessLogoutLauncherState;

  @Implements<SignOutLauncherState>()
  @Implements<FailureLauncherState>()
  const factory LauncherState.logoutFailure({required Type typeError}) =
  FailureLogoutLauncherState;

  const LauncherState._();
}

class LauncherBloc extends Bloc<LauncherEvent, LauncherState> {
  LauncherBloc(this._auth) : super(const LauncherState.initial()) {
    on<SignInLauncherEvent>(_signIn);
    on<SignOutLauncherEvent>(_signOut);
  }
  final FirebaseAuth _auth;

  Future<void> _signIn(
    SignInLauncherEvent event,
    Emitter<LauncherState> emit,
  ) async {
    emit(const LauncherState.authenticatePending());
    if(event.user != null){
      emit(const LauncherState.authenticateSuccess());
    }else{
      emit(const LauncherState.authenticateFailure(typeError: Object));
    }
  }

  Future<void> _signOut(
      SignOutLauncherEvent event,
      Emitter<LauncherState> emit,
      ) async {
    emit(const LauncherState.logoutPending());
    try {
      await _auth.signOut();
      emit(const LauncherState.logoutSuccess());
    } on Exception catch (e) {
      emit(const LauncherState.logoutFailure(typeError: Object));
    }
  }
}
