import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/register.dart';

abstract class RegisterRepository {
  Future<Either<Failure, Register>> doRegister(String name,String email,String password, String fcmKey);
}