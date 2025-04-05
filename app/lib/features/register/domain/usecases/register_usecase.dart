import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/register.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase implements UseCase<Register, RegisterParams> {
  final RegisterRepository repository;

  const RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, Register>> call(RegisterParams params) async {
    return repository.doRegister(params.name, params.email, params.password,params.fcmToken);
  }
}

class RegisterParams extends Equatable {
  final String name, email, password,fcmToken;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.fcmToken,
  });

  @override
  List<Object> get props => [name, email, password];
}
