import 'package:dartz/dartz.dart';
import 'package:github_dart_repository/data/repositories/github_repository_impl.dart';

import '../../../data/error/failure.dart';
import '../../data/models/repository_model.dart';
import '../../data/models/repository_request_model.dart';

class GithubUseCase {
  final GithubRepository _repo;

  GithubUseCase(this._repo);

  Future<Either<Failure, List<RepositoryModel>>> getRepositories(
      {required RepositoryRequestModel params}) {
    return _repo.getRepositories(params: params);
  }
}
