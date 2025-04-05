
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/register.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../../../core/usecases/usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
      final RegisterUseCase usecase;

      RegisterBloc({required this.usecase}) : super(RegisterInitial()){
            on<RegisterWithEmailEvent>((event, emit) async {
                  emit(RegisterLoading());
                  var failOrRegister = await usecase(event.params);

                  failOrRegister.fold(
                            (fail) => emit(RegisterError(message: fail.message)),
                            (register) => emit(RegisterLoaded(register)),
                  );
            });
      }
}
