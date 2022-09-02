import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pt_tz/features/app/domain/launcher_states.dart';

part 'launcher_bloc.freezed.dart';

@freezed
class LauncherEvent with _$LauncherEvent {
  const LauncherEvent._();

  const factory LauncherEvent.login({
    User? user,
  }) = LoginLauncherEvent;
}

@freezed
class LauncherState with _$LauncherState {
  const factory LauncherState.initial() = InitialLauncherState;

  @Implements<LoginLauncherState>()
  @Implements<PendingLauncherState>()
  const factory LauncherState.authenticatePending() =
      PendingAuthenticateLauncherState;

  @Implements<LoginLauncherState>()
  @Implements<SuccessLauncherState>()
  const factory LauncherState.authenticateSuccess() =
      SuccessAuthenticateLauncherState;

  @Implements<LoginLauncherState>()
  @Implements<FailureLauncherState>()
  const factory LauncherState.authenticateFailure({required Type typeError}) =
      FailureAuthenticateLauncherState;

  const LauncherState._();
}

class LauncherBloc extends Bloc<LauncherEvent, LauncherState> {
  LauncherBloc() : super(const LauncherState.initial()) {
    on<LoginLauncherEvent>(_login);
  }

  Future<void> _login(
    LoginLauncherEvent event,
    Emitter<LauncherState> emit,
  ) async {
    emit(const PendingAuthenticateLauncherState());
    if(event.user != null){
      emit(const SuccessAuthenticateLauncherState());
    }else{
      emit(const FailureAuthenticateLauncherState(typeError: Object));
    }
  }
}
