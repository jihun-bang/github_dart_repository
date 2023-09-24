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

  GithubProvider(this._useCase);

  Future<List<RepositoryModel>> getModels() async {
    final newModels = await _useCase.getRepositories(params: params);
    _models = newModels + _models;
    notifyListeners();
    return newModels;
  }

  void updateParams(RepositoryRequestModel params) {
    _params = params;
  }
}
