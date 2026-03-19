import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/features/send_money/data/datasources/send_money_remote_data_source.dart';
import 'package:finance_demo/features/send_money/domain/repositories/send_money_repository.dart';

class SendMoneyRepositoryImpl implements SendMoneyRepository {
  final SendMoneyRemoteDataSource remoteDataSource;

  SendMoneyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> sendMoney(String recipientName, double amount) async {
    try {
      await remoteDataSource.sendMoney(recipientName, amount);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to send money. Please check balance and try again.'));
    }
  }
}
