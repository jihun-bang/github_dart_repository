import 'package:flutter/material.dart';
import 'package:github_dart_repository/core/utils/logger.dart';
import 'package:github_dart_repository/data/models/repository_request_model.dart';
import 'package:github_dart_repository/presentation/providers/github_provider.dart';
import 'package:github_dart_repository/presentation/widgets/repository_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../data/models/repository_model.dart';

class RepositoriesPage extends StatefulWidget {
  const RepositoriesPage({super.key});

  @override
  State<RepositoriesPage> createState() => _RepositoriesPageState();
}

class _RepositoriesPageState extends State<RepositoriesPage> {
  final PagingController<int, RepositoryModel> _pagingController =
      PagingController(firstPageKey: 0);
  late GithubProvider _provider;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      _provider.updateParams(_provider.params
          .copyWith(page: _provider.params.page + (pageKey != 0 ? 1 : 0)));
      final newModels = await _provider.getModels();
      final isLastPage = pageKey == 80;
      if (isLastPage) {
        _pagingController.appendLastPage(newModels);
      } else {
        final nextPageKey = pageKey + newModels.length;
        _pagingController.appendPage(newModels, nextPageKey);
      }
    } catch (error) {
      Logger.e(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GithubProvider>(builder: (_, provider, ___) {
      _provider = provider;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Dart Repositories'),
        ),
        body: Column(
          children: [
            Expanded(child: repositories),
          ],
        ),
      );
    });
  }

  Widget get repositories {
    return PagedListView.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<RepositoryModel>(
        itemBuilder: (context, item, index) =>
            RepositoryCard(model: item, isSaved: true),
      ),
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}
