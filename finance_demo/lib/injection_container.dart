import 'package:dio/dio.dart';
import 'package:finance_demo/core/network/api_client.dart';
import 'package:finance_demo/core/utils/secure_storage.dart';
import 'package:finance_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:finance_demo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:finance_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:finance_demo/features/auth/domain/usecases/biometric_login.dart';
import 'package:finance_demo/features/auth/domain/usecases/login.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_demo/features/send_money/data/datasources/send_money_remote_data_source.dart';
import 'package:finance_demo/features/send_money/data/repositories/send_money_repository_impl.dart';
import 'package:finance_demo/features/send_money/domain/repositories/send_money_repository.dart';
import 'package:finance_demo/features/send_money/domain/usecases/send_money.dart';
import 'package:finance_demo/features/send_money/presentation/bloc/send_money_bloc.dart';
import 'package:finance_demo/features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'package:finance_demo/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:finance_demo/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:finance_demo/features/transactions/domain/usecases/get_transactions.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:finance_demo/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:finance_demo/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:finance_demo/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:finance_demo/features/wallet/domain/usecases/get_balance.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        biometricLogin: sl(),
        secureStorage: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => BiometricLogin(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      secureStorage: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dio: sl(),
      localAuth: sl(),
    ),
  );

  // Features - Wallet
  sl.registerFactory(() => WalletBloc(getBalance: sl()));
  sl.registerLazySingleton(() => GetBalance(sl()));
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(dio: sl()),
  );

  // Features - Transactions
  sl.registerFactory(() => TransactionBloc(getTransactions: sl()));
  sl.registerLazySingleton(() => GetTransactions(sl()));
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(dio: sl()),
  );

  // Features - Send Money
  sl.registerFactory(() => SendMoneyBloc(sendMoneyUseCase: sl()));
  sl.registerLazySingleton(() => SendMoney(sl()));
  sl.registerLazySingleton<SendMoneyRepository>(
    () => SendMoneyRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SendMoneyRemoteDataSource>(
    () => SendMoneyRemoteDataSourceImpl(dio: sl()),
  );

  // Core
  sl.registerLazySingleton(() => SecureStorage(sl()));
  sl.registerLazySingleton(() => ApiClient(sl(), sl()));

  // External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => LocalAuthentication());
  

  sl.registerLazySingleton(() => Dio()); 

}
