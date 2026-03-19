import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/features/auth/domain/entities/user.dart';
import 'package:finance_demo/features/auth/domain/repositories/auth_repository.dart';

class BiometricLogin implements UseCase<User, NoParams> {
  final AuthRepository repository;

  BiometricLogin(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.biometricLogin();
  }
}
