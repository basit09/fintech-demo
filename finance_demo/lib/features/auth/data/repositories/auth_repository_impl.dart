import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/core/utils/secure_storage.dart';
import 'package:finance_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:finance_demo/features/auth/domain/entities/user.dart';
import 'package:finance_demo/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorage secureStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      // Mock saving token
      await secureStorage.saveToken('mock_jwt_token_for_${userModel.id}');
      return Right(userModel);
    } catch (e) {
      return const Left(AuthFailure('Invalid email or password'));
    }
  }

  @override
  Future<Either<Failure, User>> biometricLogin() async {
    try {
      final userModel = await remoteDataSource.biometricLogin();
      await secureStorage.saveToken('mock_jwt_token_for_${userModel.id}');
      return Right(userModel);
    } catch (e) {
      return const Left(AuthFailure('Biometric login failed'));
    }
  }

  @override
  Future<void> logout() async {
    await secureStorage.deleteToken();
  }

  @override
  Future<bool> isBiometricAvailable() async {
    return await remoteDataSource.isBiometricAvailable();
  }
}
