import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/features/wallet/domain/usecases/get_balance.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:finance_demo/features/wallet/presentation/bloc/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetBalance getBalance;

  WalletBloc({required this.getBalance}) : super(WalletInitial()) {
    on<FetchBalanceEvent>(_onFetchBalance);
  }

  Future<void> _onFetchBalance(FetchBalanceEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    final failureOrBalance = await getBalance(NoParams());
    failureOrBalance.fold(
      (failure) => emit(WalletError(failure.message)),
      (balance) => emit(WalletLoaded(balance)),
    );
  }
}
