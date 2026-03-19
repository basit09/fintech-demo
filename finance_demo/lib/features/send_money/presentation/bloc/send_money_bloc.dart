import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_demo/features/send_money/domain/usecases/send_money.dart';
import 'package:finance_demo/features/send_money/presentation/bloc/send_money_event.dart';
import 'package:finance_demo/features/send_money/presentation/bloc/send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  final SendMoney sendMoneyUseCase;

  SendMoneyBloc({required this.sendMoneyUseCase}) : super(SendMoneyInitial()) {
    on<SubmitTransactionEvent>(_onSubmitTransaction);
  }

  Future<void> _onSubmitTransaction(SubmitTransactionEvent event, Emitter<SendMoneyState> emit) async {
    emit(SendMoneyLoading());
    final failureOrSuccess = await sendMoneyUseCase(
      SendMoneyParams(recipientName: event.recipientName, amount: event.amount),
    );
    failureOrSuccess.fold(
      (failure) => emit(SendMoneyError(failure.message)),
      (_) => emit(SendMoneySuccess()),
    );
  }
}
