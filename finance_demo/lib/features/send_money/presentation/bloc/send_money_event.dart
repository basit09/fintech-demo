import 'package:equatable/equatable.dart';

abstract class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();

  @override
  List<Object> get props => [];
}

class SubmitTransactionEvent extends SendMoneyEvent {
  final String recipientName;
  final double amount;

  const SubmitTransactionEvent({required this.recipientName, required this.amount});

  @override
  List<Object> get props => [recipientName, amount];
}
