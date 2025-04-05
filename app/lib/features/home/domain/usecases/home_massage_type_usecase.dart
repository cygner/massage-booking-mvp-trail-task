import 'package:booking_app_mvp_test/features/home/domain/entities/massage.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class HomeMassageTypeUsecase implements UseCase<List<Massage>, NoParams> {
  final HomeRepository repository;

   const HomeMassageTypeUsecase(this.repository);

  @override
  Future<Either<Failure, List<Massage>>> call(NoParams params) async {
    return repository.getAllMassage();
  }
}

