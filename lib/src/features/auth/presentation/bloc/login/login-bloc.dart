import 'package:chat_app/src/core/utils/exception/base/error.exception.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/dtos/login.dto.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginStartedHandler);
  }

  Future<void> _onLoginStartedHandler(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      final user = LoginBodyDto(email: event.email, password: event.password);
      final loggedInUser = await loginUseCase(params: user);
      emit(LoginSuccess(loggedInUser));
    } on ErrorException catch (e) {
      Logger.error('LoginBloc + ${e.toString()}');
      emit(LoginFailure(e));
    } catch (e) {
      Logger.error('LoginBloc + ${e.toString()}');
      emit(LoginFailure(ErrorException(message: "Unexpected error occurred")));
    }
  }
}
