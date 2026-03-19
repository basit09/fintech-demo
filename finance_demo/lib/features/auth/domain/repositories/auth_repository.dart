import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> biometricLogin();
  Future<void> logout();
  Future<bool> isBiometricAvailable();
}
