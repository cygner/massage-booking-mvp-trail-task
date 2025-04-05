import 'package:dartz/dartz.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/apis.dart';
import '../../../../core/error/failures.dart';
import '../models/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<Either<Failure, RegisterModel>> doRegister(
    String name,
    String email,
    String password, String fcmKey,
  );
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ApiClient client;

  RegisterRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, RegisterModel>> doRegister(
    String name,
    String email,
    String password,
    String fcmKey,
  ) async {
    try {
      var response = await client.callPOST<RegisterModel>(
        api: Apis.register,
        params: {"name": name, "email": email, "password": password,"firebase_token":fcmKey},
        parseResponse: (json,code) {
          return  code == 201 ?
               RegisterModel.fromJson(json):RegisterModel.empty();
        },
      );

      if (response.status == 201) {
        return right(response.data);
      } else {
        return left(
          ServerFailure(response.message ?? "Something went wrong from api"),
        );
      }
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
