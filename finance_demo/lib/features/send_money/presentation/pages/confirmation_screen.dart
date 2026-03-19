import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_demo/core/constants/app_colors.dart';
import 'package:finance_demo/features/send_money/presentation/bloc/send_money_bloc.dart';
import 'package:finance_demo/features/send_money/presentation/bloc/send_money_event.dart';
import 'package:finance_demo/features/send_money/presentation/bloc/send_money_state.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:finance_demo/core/routes/app_routes.dart';

class ConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const ConfirmationScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    final recipient = arguments['recipient'] as String;
    final amount = arguments['amount'] as double;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Confirm Transaction'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<SendMoneyBloc, SendMoneyState>(
        listener: (context, state) {
          if (state is SendMoneySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Money sent successfully!'), backgroundColor: AppColors.success),
            );
            // Refresh data
            context.read<WalletBloc>().add(FetchBalanceEvent());
            context.read<TransactionBloc>().add(FetchTransactionsEvent());
            
            // Navigate back to dashboard and clear stack
            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
          } else if (state is SendMoneyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text(
                          'You are sending',
                          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '\$${amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('To', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                            Text(recipient, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: state is SendMoneyLoading
                      ? null
                      : () {
                          context.read<SendMoneyBloc>().add(SubmitTransactionEvent(recipientName: recipient, amount: amount));
                        },
                  child: state is SendMoneyLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Confirm & Send', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
