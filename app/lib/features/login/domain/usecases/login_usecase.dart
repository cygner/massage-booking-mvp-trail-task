import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login.dart';
import '../repositories/login_repository.dart';

class LoginUseCase implements UseCase<Login, LoginParams> {
  final LoginRepository repository;

  const LoginUseCase(this.repository);

  @override
  Future<Either<Failure, Login>> call(LoginParams params) async {
    return repository.doLoginWithEmail(params.email, params.password,params.fcm);
  }
}

class LoginParams extends Equatable {
  final String email, password,fcm;

  const LoginParams({required this.email, required this.password, required this.fcm});

  @override
  List<Object> get props => [email, password];
}
