import 'package:connectivity_plus/connectivity_plus.dart';
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
  bool _isOffline = false;
  int _currentOption = 0;
  final PagingController<int, RepositoryModel> _pagingController =
      PagingController(firstPageKey: 0);
  late GithubProvider _provider;
  final _menu = ['Best Match', 'Most Stars', 'Recently Updated'];

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
      final connectivityResult = await (Connectivity().checkConnectivity());
      final isOffline = connectivityResult == ConnectivityResult.none;
      if (_isOffline != isOffline) {
        setState(() {
          _isOffline = isOffline;
        });
      }
      if (isOffline) {
        final newModels = await _provider.getModels(local: true);
        _pagingController.appendLastPage(newModels);
      } else {
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

      return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
                'Dart Repositories (${_isOffline ? 'Offline' : 'Online'})'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dropdownMenu,
              Expanded(child: repositories),
            ],
          ),
        ),
      );
    });
  }

  Widget get _dropdownMenu {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: DropdownMenu<int>(
        initialSelection: 0,
        onSelected: (index) {
          if (_currentOption != index && index != null) {
            _currentOption = index;
            final sort = switch (index) {
              0 => null,
              1 => SortType.stars,
              _ => SortType.updated,
            };
            _provider
                .updateParams(_provider.params.copyWith(sort: sort, page: 1));
            _provider.reset();
            _pagingController.refresh();
          }
        },
        dropdownMenuEntries: _menu.map<DropdownMenuEntry<int>>((String value) {
          return DropdownMenuEntry(value: _menu.indexOf(value), label: value);
        }).toList(),
      ),
    );
  }

  Widget get repositories {
    return PagedListView.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<RepositoryModel>(
        itemBuilder: (context, item, index) {
          return RepositoryCard(
            model: _provider.models[index],
            onTap: () {
              _provider.save(item);
            },
          );
        },
      ),
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}
