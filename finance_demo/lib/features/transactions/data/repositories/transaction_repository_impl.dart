import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'package:finance_demo/features/transactions/domain/entities/transaction.dart';
import 'package:finance_demo/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Transaction>>> getRecentTransactions() async {
    try {
      final transactions = await remoteDataSource.getRecentTransactions();
      return Right(transactions);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
