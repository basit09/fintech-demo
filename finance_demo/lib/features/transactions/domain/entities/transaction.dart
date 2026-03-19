import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String title;
  final double amount;
  final String type; // 'credit' or 'debit'
  final DateTime date;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, amount, type, date];
}
