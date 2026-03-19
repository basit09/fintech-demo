import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/features/transactions/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> getRecentTransactions();
}
