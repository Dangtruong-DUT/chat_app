import 'package:chat_app/src/core/utils/exception/base/error.exception.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase,
      super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginStartedHandler);
  }

  Future<void> _onLoginStartedHandler(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      final user = LoginUseCaseParams(
        email: event.email,
        password: event.password,
      );
      final loggedInUser = await _loginUseCase.call(params: user);
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
