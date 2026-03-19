import 'package:dio/dio.dart';
import 'package:finance_demo/features/auth/data/models/user_model.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> biometricLogin();
  Future<bool> isBiometricAvailable();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final LocalAuthentication localAuth;

  AuthRemoteDataSourceImpl({required this.dio, required this.localAuth});

  @override
  Future<UserModel> login(String email, String password) async {
    // Mocking an API call with Future.delayed
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == 'test@example.com' && password == 'password123') {
      return const UserModel(
        id: '12345',
        email: 'test@example.com',
        name: 'John Doe',
      );
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/login'),
          statusCode: 401,
          statusMessage: 'Invalid credentials',
        ),
      );
    }
  }

  @override
  Future<UserModel> biometricLogin() async {
    final canCheckBiometrics = await localAuth.canCheckBiometrics;
    final isDeviceSupported = await localAuth.isDeviceSupported();

    if (!canCheckBiometrics || !isDeviceSupported) {
      throw Exception('Biometrics not available');
    }

    final authenticated = await localAuth.authenticate(
      localizedReason: 'Please authenticate to login to your wallet',
      persistAcrossBackgrounding: true,
      biometricOnly: true,
    );

    if (authenticated) {
      // Mocking biometric API call success
      await Future.delayed(const Duration(seconds: 1));
      return const UserModel(
        id: '12345',
        email: 'test@example.com',
        name: 'John Doe',
      );
    } else {
      throw Exception('Biometric authentication failed');
    }
  }

  @override
  Future<bool> isBiometricAvailable() async {
    final canCheckBiometrics = await localAuth.canCheckBiometrics;
    final isDeviceSupported = await localAuth.isDeviceSupported();
    return canCheckBiometrics || isDeviceSupported;
  }
}
