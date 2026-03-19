import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/features/transactions/domain/entities/transaction.dart';
import 'package:finance_demo/features/transactions/domain/repositories/transaction_repository.dart';

class GetTransactions implements UseCase<List<Transaction>, NoParams> {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async {
    return await repository.getRecentTransactions();
  }
}
