import 'package:flutter/widgets.dart';
import 'package:github_dart_repository/core/utils/logger.dart';
import 'package:github_dart_repository/data/models/repository_model.dart';

import '../../data/models/repository_request_model.dart';
import '../../domain/usecases/github_usecase.dart';

class GithubProvider extends ChangeNotifier {
  final GithubUseCase _useCase;

  List<RepositoryModel> _models = const [];
  List<RepositoryModel> get models => _models;

  RepositoryRequestModel _params = const RepositoryRequestModel();
  RepositoryRequestModel get params => _params;

  GithubProvider(this._useCase);

  Future<List<RepositoryModel>> getModels({bool local = false}) async {
    if (local) {
      reset();
    }
    Logger.e(models.length);
    final newModels = await (local
        ? _useCase.getLocalModels()
        : _useCase.getRepositories(params: params));
    _models = _models + newModels;
    final localModels = await _useCase.getLocalModels();
    for (var model in models) {
      _models = _useCase.updateSaved(
          models: models, localModels: localModels, checkModel: model);
    }
    notifyListeners();
    return newModels;
  }

  void updateParams(RepositoryRequestModel params) {
    _params = params;
  }

  void reset() {
    _models = [];
    _params = const RepositoryRequestModel();
    notifyListeners();
  }

  Future<void> save(RepositoryModel newModel) async {
    await _useCase.save(models: models, newModel: newModel);
    final localModels = await _useCase.getLocalModels();
    _models = _useCase.updateSaved(
        models: models, localModels: localModels, checkModel: newModel);
    notifyListeners();
  }
}
