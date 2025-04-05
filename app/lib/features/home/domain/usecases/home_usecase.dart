import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/home.dart';
import '../repositories/home_repository.dart';

class HomeUseCase implements UseCase<Home, String> {
  final HomeRepository repository;

   const HomeUseCase(this.repository);

  @override
  Future<Either<Failure, Home>> call(String id) async {
    return repository.getHistory(id);
  }
}

