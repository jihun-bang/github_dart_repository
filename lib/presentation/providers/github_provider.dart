import 'package:flutter/widgets.dart';
import 'package:github_dart_repository/data/models/repository_model.dart';

import '../../data/models/repository_request_model.dart';
import '../../domain/usecases/github_usecase.dart';

class GithubProvider extends ChangeNotifier {
  final GithubUseCase _useCase;

  List<RepositoryModel> _models = const [];
  List<RepositoryModel> get models => _models;

  RepositoryRequestModel _params = const RepositoryRequestModel();
  RepositoryRequestModel get params => _params;

  GithubProvider(this._useCase) {
    updateModels();
  }

  Future<void> updateModels() async {
    _models = await _useCase.getRepositories(params: params);
    notifyListeners();
  }

  void updateParams(RepositoryRequestModel params) {
    _params = params;
  }
}
