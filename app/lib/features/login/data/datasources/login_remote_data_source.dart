import 'package:dartz/dartz.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/apis.dart';
import '../../../../core/error/failures.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, LoginModel>> doLoginWithEmail(
    String email,
    String password, String fcmKey,
  );
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, LoginModel>> doLoginWithEmail(
    String email,
    String password,String fcmKey
  ) async {
    try {
      var response = await client.callPOST<LoginModel>(
        api: Apis.login,
        params: {"email": email, "password": password,"firebase_token":fcmKey},
        parseResponse: (json,code) {
          return code == 201 ?LoginModel.fromJson(json):LoginModel.empty();
        },
      );

      if (response.status == 201) {
        return right(response.data);
      } else {
        return left(ServerFailure(response.message??"Something went wrong from api"));
      }
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
