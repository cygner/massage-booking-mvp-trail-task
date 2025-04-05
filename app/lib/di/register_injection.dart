import '../features/register/presentation/bloc/register_bloc.dart';
import '../features/register/domain/usecases/register_usecase.dart';
import '../features/register/data/datasources/register_remote_data_source.dart';
import '../features/register/data/repositories/register_repository_impl.dart';
import '../features/register/domain/repositories/register_repository.dart';
import 'package:get_it/get_it.dart';


Future<void> registerInjection(GetIt sl) async {

  // Features - Register
  // Bloc
  
  sl.registerFactory(() => RegisterBloc(usecase: sl()));
  
  // Use cases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Repository
  sl.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<RegisterRemoteDataSource>(
        () => RegisterRemoteDataSourceImpl(client: sl()),
  );
}