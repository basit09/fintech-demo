import 'package:equatable/equatable.dart';
import 'package:finance_demo/features/wallet/domain/entities/balance.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final Balance balance;

  const WalletLoaded(this.balance);

  @override
  List<Object> get props => [balance];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object> get props => [message];
}
