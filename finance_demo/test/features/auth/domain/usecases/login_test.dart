import 'package:dartz/dartz.dart';
import 'package:finance_demo/features/auth/domain/entities/user.dart';
import 'package:finance_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:finance_demo/features/auth/domain/usecases/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late Login usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = Login(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = User(id: '1', email: tEmail, name: 'Test User');

  test('should return User from the repository when login is successful', () async {
    // arrange
    when(() => mockAuthRepository.login(tEmail, tPassword))
        .thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(const LoginParams(email: tEmail, password: tPassword));

    // assert
    expect(result, const Right(tUser));
    verify(() => mockAuthRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
