import 'package:dio/dio.dart';
import 'package:finance_demo/features/transactions/data/models/transaction_model.dart';
import 'package:finance_demo/features/transactions/domain/entities/transaction.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getRecentTransactions();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TransactionModel>> getRecentTransactions() async {
    // Mock the API response
    await Future.delayed(const Duration(milliseconds: 600));

    // Simulating API response with dummy transactions
    return [
      TransactionModel(
        id: '1',
        title: 'Starbucks Coffee',
        amount: 5.50,
        type: 'debit',
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TransactionModel(
        id: '2',
        title: 'Salary Deposit',
        amount: 3200.00,
        type: 'credit',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TransactionModel(
        id: '3',
        title: 'Uber Ride',
        amount: 12.50,
        type: 'debit',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      TransactionModel(
        id: '4',
        title: 'Amazon Fresh',
        amount: 45.00,
        type: 'debit',
        date: DateTime.now().subtract(const Duration(days: 4)),
      ),
      TransactionModel(
        id: '5',
        title: 'Refund - Nike',
        amount: 120.00,
        type: 'credit',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }
}
