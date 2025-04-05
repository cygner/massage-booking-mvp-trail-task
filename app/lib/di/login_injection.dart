import '../features/login/presentation/bloc/login_bloc.dart';
import '../features/login/domain/usecases/login_usecase.dart';
import '../features/login/data/datasources/login_remote_data_source.dart';
import '../features/login/data/repositories/login_repository_impl.dart';
import '../features/login/domain/repositories/login_repository.dart';
import 'package:get_it/get_it.dart';


Future<void> loginInjection(GetIt sl) async {

  // Features - Login
  // Bloc
  
  sl.registerFactory(() => LoginBloc(usecase: sl()));
  
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(client: sl()),
  );
}