import 'package:dartz/dartz.dart';
import 'package:github_dart_repository/data/models/repository_model.dart';

import '../dio/dio_client.dart';
import '../error/failure.dart';
import '../models/repository_request_model.dart';

abstract class GithubRemoteDatasource {
  Future<Either<Failure, List<RepositoryModel>>> getRepositories(
      {required RepositoryRequestModel params});
}

class GithubRemoteDatasourceImpl implements GithubRemoteDatasource {
  final DioClient _client;

  GithubRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, List<RepositoryModel>>> getRepositories(
      {required RepositoryRequestModel params}) async {
    final response = await _client.getRequest(
      '/search/repositories?q=${params.sort == null ? 'dart+' : ''}language:dart',
      queryParameters: params.toJson(),
      converter: (response) => (response['items'] as List)
          .map((e) => RepositoryModel.fromJson(e))
          .toList(),
    );

    return response;
  }
}
