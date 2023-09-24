import 'package:get_it/get_it.dart';
import 'package:github_dart_repository/data/data_sources/github_remote_datasources.dart';
import 'package:github_dart_repository/data/repositories/github_repository_impl.dart';
import 'package:github_dart_repository/domain/usecases/github_usecase.dart';
import 'package:github_dart_repository/presentation/providers/github_provider.dart';

import 'data/dio/dio_client.dart';

GetIt sl = GetIt.instance;

void setupLocator() async {
  /// DataSource
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton<GithubRemoteDatasource>(
    () => GithubRemoteDatasourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<GithubRepository>(() => GithubRepositoryImpl(sl()));

  /// UseCase
  sl.registerLazySingleton<GithubUseCase>(() => GithubUseCase(sl()));

  /// Provider
  sl.registerFactory<GithubProvider>(() => GithubProvider(sl()));
}
