import 'package:booking_app_mvp_test/features/home/domain/usecases/home_book_usecase.dart';
import 'package:booking_app_mvp_test/features/home/domain/usecases/home_massage_type_usecase.dart';

import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/home/domain/usecases/home_usecase.dart';
import '../features/home/data/datasources/home_remote_data_source.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import 'package:get_it/get_it.dart';


Future<void> homeInjection(GetIt sl) async {

  // Features - Home
  // Bloc
  
  sl.registerFactory(() => HomeBloc(usecase: sl(),bookingUsecase: sl(),homeMassageTypeUsecase: sl()));
  
  // Use cases
  sl.registerLazySingleton(() => HomeUseCase(sl()));
  sl.registerLazySingleton(() => HomeBookUsecase(sl()));
  sl.registerLazySingleton(() => HomeMassageTypeUsecase(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(client: sl()),
  );
}