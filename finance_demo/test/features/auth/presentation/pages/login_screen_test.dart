import 'package:bloc_test/bloc_test.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_event.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_state.dart';
import 'package:finance_demo/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const LoginScreen(),
      ),
    );
  }

  testWidgets('should display email and password text fields', (WidgetTester tester) async {
    // arrange
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Login with Biometrics'), findsOneWidget);
  });

  testWidgets('should show loading indicator when state is AuthLoading', (WidgetTester tester) async {
    // arrange
    when(() => mockAuthBloc.state).thenReturn(AuthLoading());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
