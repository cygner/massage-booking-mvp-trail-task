import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/login.dart';
import '../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase usecase;

  LoginBloc({required this.usecase}) : super(LoginInitial()) {
    on<LoginWithEmailEvent>((event, emit) async {
      emit(LoginLoading());
      var failOrLogin = await usecase(event.params);

      print(failOrLogin);
      failOrLogin.fold(
        (fail) => emit(LoginError(message: fail.message)),
        (login) => emit(LoginLoaded(login)),
      );
    });
  }
}
