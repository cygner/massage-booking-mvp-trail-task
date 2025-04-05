import 'package:booking_app_mvp_test/features/home/domain/entities/home.dart';
import 'package:booking_app_mvp_test/features/home/domain/entities/massage.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, int>> doBooking(int massage_id,
      String booking_time,
      String email);


  Future<Either<Failure, List<Massage>>> getAllMassage();

  Future<Either<Failure, Home>> getHistory(String id);
}