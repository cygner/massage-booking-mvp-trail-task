import 'package:booking_app_mvp_test/core/api/api_client.dart';
import 'package:booking_app_mvp_test/core/api/api_client_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/network/network_info.dart';
import 'login_injection.dart';
import 'register_injection.dart';

import 'home_injection.dart';
import 'splash_injection.dart';
final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  // Features - will call all feature injection methods
  await initFeatures();
}

// This method will dynamically call all feature injections
Future<void> initFeatures() async {
  final featureInitializers = {
    // Will be populated by Mason
    'login': loginInjection,
    'register': registerInjection,
    'home': homeInjection,
  'splash': splashInjection,
};

  // Call each feature's injection method
  for (final initialize in featureInitializers.values) {
    await initialize(sl);
  }
}
