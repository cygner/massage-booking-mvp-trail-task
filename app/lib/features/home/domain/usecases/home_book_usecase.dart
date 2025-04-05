import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/home.dart';
import '../repositories/home_repository.dart';

class HomeBookUsecase implements UseCase<int, BookParams> {
  final HomeRepository repository;

   const HomeBookUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(BookParams params) async {
    return repository.doBooking(params.massage_id, params.booking_time, params.email);
  }
}

class BookParams extends Equatable {
  final int massage_id;
  final String booking_time;
  final String email;

  const BookParams({required this.massage_id, required this.booking_time, required this.email});

  @override
  List<Object> get props => [massage_id];
}
