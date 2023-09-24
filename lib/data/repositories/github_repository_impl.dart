import 'package:dartz/dartz.dart';

import '../../data/error/failure.dart';
import '../../data/models/repository_model.dart';
import '../../data/models/repository_request_model.dart';
import '../data_sources/github_remote_datasources.dart';

abstract class GithubRepository {
  Future<Either<Failure, List<RepositoryModel>>> getRepositories(
      {required RepositoryRequestModel params});
}

class GithubRepositoryImpl implements GithubRepository {
  final GithubRemoteDatasource remoteDatasource;

  const GithubRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<RepositoryModel>>> getRepositories(
      {required RepositoryRequestModel params}) async {
    final response = await remoteDatasource.getRepositories(params: params);

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }
}
