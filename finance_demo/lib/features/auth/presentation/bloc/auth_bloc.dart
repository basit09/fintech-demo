import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_demo/core/usecases/usecase.dart';
import 'package:finance_demo/core/utils/secure_storage.dart';
import 'package:finance_demo/features/auth/domain/usecases/biometric_login.dart';
import 'package:finance_demo/features/auth/domain/usecases/login.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_event.dart';
import 'package:finance_demo/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final BiometricLogin biometricLogin;
  final SecureStorage secureStorage;

  AuthBloc({
    required this.login,
    required this.biometricLogin,
    required this.secureStorage,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<BiometricLoginEvent>(_onBiometricLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrUser = await login(
      LoginParams(email: event.email, password: event.password),
    );
    failureOrUser.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onBiometricLogin(
      BiometricLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrUser = await biometricLogin(NoParams());
    failureOrUser.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await secureStorage.deleteToken();
    emit(Unauthenticated());
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final token = await secureStorage.getToken();
    if (token != null && token.isNotEmpty) {
      // Mocking validation logic: If token exists, login silently with biometrics if possible
      final isBiometricEnabled = await secureStorage.isBiometricEnabled();
      if (isBiometricEnabled) {
        add(BiometricLoginEvent());
      } else {
        // Assume active session
         emit(AuthError('Session expired. Please login again.'));
      }
    } else {
      emit(Unauthenticated());
    }
  }
}
