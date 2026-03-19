import 'package:dartz/dartz.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/features/wallet/domain/entities/balance.dart';
import 'package:finance_demo/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:finance_demo/features/wallet/domain/usecases/get_balance.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWalletRepository extends Mock implements WalletRepository {}

void main() {
  late GetBalance usecase;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
    usecase = GetBalance(mockWalletRepository);
  });

  const tBalance = Balance(currentBalance: 5000.0, currency: 'USD');

  test('should get balance from the repository', () async {
    // arrange
    when(() => mockWalletRepository.getBalance())
        .thenAnswer((_) async => const Right(tBalance));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(tBalance));
    verify(() => mockWalletRepository.getBalance());
    verifyNoMoreInteractions(mockWalletRepository);
  });
}
