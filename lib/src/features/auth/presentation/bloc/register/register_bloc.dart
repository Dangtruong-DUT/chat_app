import 'package:chat_app/src/features/auth/domain/usecases/register.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register_state.dart';
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
    final params = RegisterUseCaseParams(
      email: event.email,
      name: event.name,
      password: event.password,
    );

    final result = await _registerUseCase.call(params);
    result.fold(
      (error) => emit(RegisterFailure(error)),
      (user) => emit(RegisterSuccess(user)),
    );
  }
}
