import 'package:finance_demo/features/wallet/domain/entities/balance.dart';

class BalanceModel extends Balance {
  const BalanceModel({
    required super.currentBalance,
    required super.currency,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      currentBalance: (json['currentBalance'] as num).toDouble(),
      currency: json['currency'] ?? 'USD',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentBalance': currentBalance,
      'currency': currency,
    };
  }
}
