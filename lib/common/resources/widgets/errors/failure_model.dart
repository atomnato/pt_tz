import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pt_tz/common/resources/widgets/errors/error_type.dart';

part 'failure_model.freezed.dart';

abstract class Failure{
  String get getMessage;
}

@freezed
class AuthFailure with _$AuthFailure implements Failure{
  factory AuthFailure({
    required AuthErrorType type,
    required String message,
  }) = _AuthFailure;

  const AuthFailure._();

  @override
  String get getMessage => message;
}

@freezed
class BaseFailure with _$BaseFailure implements Failure{
  factory BaseFailure({
    required ErrorType type,
    required String message,
  }) = _BaseFailure;

  const BaseFailure._();

  @override
  String get getMessage => message;
}
