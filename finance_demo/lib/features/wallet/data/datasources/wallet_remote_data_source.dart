import 'package:dio/dio.dart';
import 'package:finance_demo/features/wallet/data/models/balance_model.dart';

abstract class WalletRemoteDataSource {
  Future<BalanceModel> getBalance();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final Dio dio;

  WalletRemoteDataSourceImpl({required this.dio});

  @override
  Future<BalanceModel> getBalance() async {
    // Mock the API response
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simulating an API successful response for balance
    return const BalanceModel(
      currentBalance: 5432.50,
      currency: 'USD',
    );
  }
}
