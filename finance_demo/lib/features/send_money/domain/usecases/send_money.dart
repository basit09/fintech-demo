import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_demo/core/error/failures.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/features/send_money/domain/repositories/send_money_repository.dart';

class SendMoney implements UseCase<void, SendMoneyParams> {
  final SendMoneyRepository repository;

  SendMoney(this.repository);

  @override
  Future<Either<Failure, void>> call(SendMoneyParams params) async {
    return await repository.sendMoney(params.recipientName, params.amount);
  }
}

class SendMoneyParams extends Equatable {
  final String recipientName;
  final double amount;

  const SendMoneyParams({required this.recipientName, required this.amount});

  @override
  List<Object?> get props => [recipientName, amount];
}
