import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_demo/core/constants/app_colors.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_event.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_state.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_state.dart';
import 'package:finance_demo/core/routes/app_routes.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(FetchBalanceEvent());
    context.read<TransactionBloc>().add(FetchTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<WalletBloc>().add(FetchBalanceEvent());
            context.read<TransactionBloc>().add(FetchTransactionsEvent());
          },
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildBalanceCard(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildTransactionsList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.sendMoney);
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.send, color: Colors.white),
          label: const Text('Send Money', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletLoading || state is WalletInitial) {
          return const Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is WalletError) {
          return Card(
            color: AppColors.error.withOpacity(0.1),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ),
          );
        } else if (state is WalletLoaded) {
          final balance = state.balance;
          final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
          
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatter.format(balance.currentBalance),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          balance.currency,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTransactionsList() {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading || state is TransactionInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TransactionError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.error),
              ),
            ),
          );
        } else if (state is TransactionLoaded) {
          final transactions = state.transactions;
          if (transactions.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'No recent transactions',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            );
          }

          final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
          final dateFormatter = DateFormat('MMM dd, yyyy');

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final tx = transactions[index];
              final isCredit = tx.type == 'credit';
              
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: isCredit ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                  child: Icon(
                    isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isCredit ? AppColors.success : AppColors.error,
                  ),
                ),
                title: Text(
                  tx.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(dateFormatter.format(tx.date)),
                trailing: Text(
                  '${isCredit ? '+' : '-'}${formatter.format(tx.amount)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isCredit ? AppColors.success : AppColors.textPrimary,
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
