import 'package:dartz/dartz.dart';

import '../../data/error/failure.dart';
import '../../data/models/repository_model.dart';
import '../../data/models/repository_request_model.dart';

abstract class GithubRepository {
  Future<Either<Failure, List<RepositoryModel>>> getRepositories(
      {required RepositoryRequestModel params});
}
