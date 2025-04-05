import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/api_client.dart';
import '../models/splash_model.dart';

abstract class SplashRemoteDataSource {

}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
    final ApiClient client;


   SplashRemoteDataSourceImpl({
      required this.client
    });

}