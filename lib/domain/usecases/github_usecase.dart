import 'package:github_dart_repository/data/repositories/github_repository_impl.dart';

import '../../data/models/repository_model.dart';
import '../../data/models/repository_request_model.dart';

class GithubUseCase {
  final GithubRepository _repo;

  GithubUseCase(this._repo);

  Future<List<RepositoryModel>> getRepositories(
      {required RepositoryRequestModel params}) {
    return _repo.getRepositories(params: params).then((value) => value.fold(
          (l) => [],
          (r) => r,
        ));
  }
}
