import 'package:dio/dio.dart';
import 'package:finance_demo/core/utils/secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final SecureStorage _secureStorage;

  ApiClient(this._dio, this._secureStorage) {
    _dio.options.baseUrl = 'https://api.mockfintech.com/v1'; // Mock base URL
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Handle 401 unauthorized globally
          if (e.response?.statusCode == 401) {
            // trigger a logout or token refresh.
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
