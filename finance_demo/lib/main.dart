import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_demo/core/constants/app_colors.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_event.dart';
import 'package:finance_demo/features/send_money/presentation/bloc/send_money_bloc.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:finance_demo/core/routes/app_routes.dart';
import 'package:finance_demo/core/routes/app_router.dart';
import 'package:finance_demo/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const FinWalletApp());
}

class FinWalletApp extends StatelessWidget {
  const FinWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<WalletBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<TransactionBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<SendMoneyBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'FinWallet Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Roboto', // Modern standard
          
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            error: AppColors.error,
          ),
          
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
          
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: const Color(0xFF121212),
          colorScheme: ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: Colors.grey[900]!,
          ),
        ),
        themeMode: ThemeMode.system, // Supports both dark & light
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
