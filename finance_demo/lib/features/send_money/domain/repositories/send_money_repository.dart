import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';

abstract class SendMoneyRepository {
  Future<Either<Failure, void>> sendMoney(String recipientName, double amount);
}
