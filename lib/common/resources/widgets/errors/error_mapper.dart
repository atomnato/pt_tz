import 'package:firebase_auth/firebase_auth.dart';
import 'package:pt_tz/common/resources/widgets/errors/error_type.dart';
import 'package:pt_tz/common/resources/widgets/errors/failure_model.dart';

class ErrorMapper {
  static Failure map(Exception e) {
    var errorType = ErrorType.somethingWentWrong;
    if (e is FirebaseAuthException) {
      var errorAuthType = AuthErrorType.unknownError;
      switch (e.code) {
        case 'user-not-found':
          errorAuthType = AuthErrorType.unknownEmail;
          break;
        case 'wrong-password':
          errorAuthType = AuthErrorType.invalidPassword;
          break;
      }
      return AuthFailure(
        type: errorAuthType,
        message: e.message ?? e.toString(),
      );
    }
    return BaseFailure(
      type: errorType,
      message: e.toString(),
    );
  }
}
