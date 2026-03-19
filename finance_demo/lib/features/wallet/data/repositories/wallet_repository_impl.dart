import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:finance_demo/features/wallet/domain/entities/balance.dart';
import 'package:finance_demo/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Balance>> getBalance() async {
    try {
      final balanceModel = await remoteDataSource.getBalance();
      return Right(balanceModel);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
