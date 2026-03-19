import 'package:dio/dio.dart';

abstract class SendMoneyRemoteDataSource {
  Future<void> sendMoney(String recipientName, double amount);
}

class SendMoneyRemoteDataSourceImpl implements SendMoneyRemoteDataSource {
  final Dio dio;

  SendMoneyRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> sendMoney(String recipientName, double amount) async {
    // Mocking an API call for sending money
    await Future.delayed(const Duration(seconds: 1));

    if (amount > 5000) { // arbitrary limit for demonstration
       throw DioException(
        requestOptions: RequestOptions(path: '/send-money'),
        response: Response(
          requestOptions: RequestOptions(path: '/send-money'),
          statusCode: 400,
          statusMessage: 'Insufficient balance or limit exceeded',
        ),
      );
    }
  }
}
