import 'package:chat_app/src/core/utils/exception/base/error.exception.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/usecases/register.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register-event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({required RegisterUseCase registerUseCase})
    : _registerUseCase = registerUseCase,
      super(const RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterStartedHandler);
  }

  Future<void> _onRegisterStartedHandler(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterLoading());
    try {
      final body = RegisterUseCaseParams(
        email: event.email,
        name: event.name,
        password: event.password,
      );
      final registeredUser = await _registerUseCase.call(params: body);
      emit(RegisterSuccess(registeredUser));
    } on ErrorException catch (e) {
      Logger.error('RegisterBloc + ${e.toString()}');
      emit(RegisterFailure(e));
    } catch (e) {
      Logger.error('RegisterBloc + ${e.toString()}');
      emit(
        RegisterFailure(ErrorException(message: "Unexpected error occurred")),
      );
    }
  }
}
