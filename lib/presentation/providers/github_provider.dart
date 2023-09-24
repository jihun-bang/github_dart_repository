import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:github_dart_repository/data/models/repository_model.dart';

import '../../data/models/repository_request_model.dart';
import '../../domain/usecases/github_usecase.dart';
import '../../main.dart';

class GithubProvider extends ChangeNotifier {
  final GithubUseCase _useCase;

  List<RepositoryModel> _models = const [];
  List<RepositoryModel> get models => _models;

  RepositoryRequestModel _params = const RepositoryRequestModel();
  RepositoryRequestModel get params => _params;

  GithubProvider(this._useCase);

  Future<List<RepositoryModel>> getModels() async {
    final newModels = await _useCase.getRepositories(params: params);
    _models = _models + newModels;
    final localModels = await _getLocalModels();
    for (var model in models) {
      _updateSaved(localModels: localModels, checkModel: model);
    }
    notifyListeners();
    return newModels;
  }

  void updateParams(RepositoryRequestModel params) {
    _params = params;
  }

  Future<void> save(RepositoryModel newModel) async {
    final localModels = await _getLocalModels();
    final hasNotModel =
        localModels.indexWhere((localModel) => localModel.id == newModel.id) ==
            -1;
    if (hasNotModel) {
      final newLocalModels = localModels + [newModel];
      await storage.write(
          key: 'repositories', value: jsonEncode(newLocalModels));
      _updateSaved(localModels: newLocalModels, checkModel: newModel);
    }
  }

  Future<List<RepositoryModel>> _getLocalModels() async {
    return (jsonDecode(await storage.read(key: 'repositories') ?? '[]') as List)
        .map((e) => RepositoryModel.fromJson(e))
        .toList();
  }

  void _updateSaved({
    required List<RepositoryModel> localModels,
    required RepositoryModel checkModel,
  }) async {
    final index =
        localModels.indexWhere((localModel) => localModel.id == checkModel.id);
    if (index != -1) {
      _models[models.indexWhere((model) => model.id == checkModel.id)] =
          checkModel.copyWith(isSaved: true);
    }
    notifyListeners();
  }
}
