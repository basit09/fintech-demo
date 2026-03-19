import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/features/wallet/domain/entities/balance.dart';

abstract class WalletRepository {
  Future<Either<Failure, Balance>> getBalance();
}
