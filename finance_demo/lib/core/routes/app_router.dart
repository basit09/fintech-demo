import 'package:flutter/material.dart';
import 'package:finance_demo/core/routes/app_routes.dart';
import 'package:finance_demo/features/auth/presentation/pages/login_screen.dart';
import 'package:finance_demo/features/send_money/presentation/pages/confirmation_screen.dart';
import 'package:finance_demo/features/send_money/presentation/pages/send_money_screen.dart';
import 'package:finance_demo/features/wallet/presentation/pages/dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case AppRoutes.sendMoney:
        return MaterialPageRoute(builder: (_) => const SendMoneyScreen());
      case AppRoutes.confirmation:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ConfirmationScreen(
            arguments: args ?? {'recipient': 'Unknown', 'amount': 0.0},
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
