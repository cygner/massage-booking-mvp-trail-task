import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> doLoginWithEmail(String email,String password,String fcmKey);
}