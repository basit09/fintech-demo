import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/features/transactions/domain/usecases/get_transactions.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:finance_demo/features/transactions/presentation/bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;

  TransactionBloc({required this.getTransactions}) : super(TransactionInitial()) {
    on<FetchTransactionsEvent>(_onFetchTransactions);
  }

  Future<void> _onFetchTransactions(FetchTransactionsEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final failureOrTransactions = await getTransactions(NoParams());
    failureOrTransactions.fold(
      (failure) => emit(TransactionError(failure.message)),
      (transactions) => emit(TransactionLoaded(transactions)),
    );
  }
}
