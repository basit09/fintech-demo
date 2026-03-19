import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/features/wallet/domain/entities/balance.dart';
import 'package:finance_demo/features/wallet/domain/repositories/wallet_repository.dart';

class GetBalance implements UseCase<Balance, NoParams> {
  final WalletRepository repository;

  GetBalance(this.repository);

  @override
  Future<Either<Failure, Balance>> call(NoParams params) async {
    return await repository.getBalance();
  }
}
