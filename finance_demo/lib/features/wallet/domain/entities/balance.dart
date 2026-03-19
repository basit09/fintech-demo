import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  final double currentBalance;
  final String currency;

  const Balance({
    required this.currentBalance,
    required this.currency,
  });

  @override
  List<Object?> get props => [currentBalance, currency];
}
