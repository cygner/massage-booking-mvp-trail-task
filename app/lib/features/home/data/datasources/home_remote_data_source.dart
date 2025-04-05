import 'dart:convert';
import 'package:dartz/dartz.dart';

import '../../../../core/api/apis.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/home.dart';
import '../../domain/entities/massage.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, int>> doBooking(int massage_id, String booking_time, String email);
  Future<Either<Failure, List<MassageModel>>> getAllMassage();
  Future<Either<Failure, Home>> getHistory(String id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
    final ApiClient client;


   HomeRemoteDataSourceImpl({
      required this.client
    });

  @override
  Future<Either<Failure, int>> doBooking(int massage_id, String booking_time, String email) async {
    try {
      var response = await client.callPOST<int>(
        api: Apis.booking,
        params: {"massage_id": massage_id.toString(), "email": email, "booking_time": booking_time},
        parseResponse: (json,code) {

          return code == 201 ? json ['booking_ref_id'] :0;
        },
      );

      print(response.toMap().toString());
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

  @override
  Future<Either<Failure, List<MassageModel>>> getAllMassage() async {
    try {
      var response = await client.callGET<List<MassageModel>>(
        api: Apis.massage,
        parseResponse: (json,code) {
          var list = <MassageModel>[];
          for(var massage in json as List){
            list.add(MassageModel.fromJson(massage));
          }
          return code == 200 ?list:[]
             ;
        },
      );

      print(response.toMap().toString());
      if (response.status == 200) {
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

  @override
  Future<Either<Failure, Home>> getHistory(String id) async {
    try {
      var response = await client.callGET<Home>(
        api: Apis.history,
        urlParams: {"id":id},
        parseResponse: (json,code) {
        return HomeModel.fromJson(json);
        },
      );

      print(response.toMap().toString());
      if (response.status == 200) {
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