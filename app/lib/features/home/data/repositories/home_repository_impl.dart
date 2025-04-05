import 'package:booking_app_mvp_test/features/home/domain/entities/home.dart';
import 'package:booking_app_mvp_test/features/home/domain/entities/massage.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>> doBooking(
    int massage_id,
    String booking_time,
    String email,
  ) {
    print(massage_id);
    print(booking_time);
    print(email);
    return remoteDataSource.doBooking(massage_id, booking_time, email);
  }

  @override
  Future<Either<Failure, List<Massage>>> getAllMassage() {
  return remoteDataSource.getAllMassage();
  }

  @override
  Future<Either<Failure, Home>> getHistory(String id) {
    return remoteDataSource.getHistory(id);
  }
}
