import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/register.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_data_source.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Register>> doRegister(
    String name,
    String email,
    String password,
    String fcmKey,
  ) {
    return remoteDataSource.doRegister(name, email, password,fcmKey);
  }
}
