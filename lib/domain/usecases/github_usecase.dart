import 'dart:convert';

import 'package:github_dart_repository/data/repositories/github_repository_impl.dart';

import '../../data/models/repository_model.dart';
import '../../data/models/repository_request_model.dart';
import '../../main.dart';

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

  Future<List<RepositoryModel>> getLocalModels() async {
    return (jsonDecode(await storage.read(key: 'repositories') ?? '[]') as List)
        .map((e) => RepositoryModel.fromJson(e))
        .toList();
  }

  Future<void> save({
    required List<RepositoryModel> models,
    required RepositoryModel newModel,
  }) async {
    final localModels = await getLocalModels();
    final hasNotModel =
        localModels.indexWhere((localModel) => localModel.id == newModel.id) ==
            -1;
    if (hasNotModel) {
      final newLocalModels = localModels + [newModel];
      await storage.write(
          key: 'repositories', value: jsonEncode(newLocalModels));
    }
  }

  List<RepositoryModel> updateSaved({
    required List<RepositoryModel> models,
    required List<RepositoryModel> localModels,
    required RepositoryModel checkModel,
  }) {
    final index =
        localModels.indexWhere((localModel) => localModel.id == checkModel.id);
    if (index != -1) {
      models[models.indexWhere((model) => model.id == checkModel.id)] =
          checkModel.copyWith(isSaved: true);
    }
    return models;
  }
}
