import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:github_dart_repository/data/models/repository_request_model.dart';
import 'package:github_dart_repository/presentation/providers/github_provider.dart';
import 'package:github_dart_repository/presentation/widgets/repository_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../core/utils/logger.dart';
import '../../data/models/repository_model.dart';
import '../../dependencies_injection.dart';

class RepositoriesOnlinePage extends StatefulWidget {
  const RepositoriesOnlinePage({super.key});

  @override
  State<RepositoriesOnlinePage> createState() => _RepositoriesOnlinePageState();
}

class _RepositoriesOnlinePageState extends State<RepositoriesOnlinePage> {
  late StreamSubscription _subscription;
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

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      final isOffline = result == ConnectivityResult.none;
      if (isOffline) {
        _provider.reset();
        _pagingController.refresh();
      } else {
        _fetchPage(0);
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _subscription.cancel();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
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
    } else {
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GithubProvider>(
      create: (_) {
        _provider = sl<GithubProvider>();
        return _provider;
      },
      child: Consumer<GithubProvider>(builder: (_, provider, ___) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdownMenu,
            Expanded(child: repositories),
          ],
        );
      }),
    );
  }

  Widget get _dropdownMenu {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: DropdownMenu<int>(
        enableSearch: false,
        initialSelection: _provider.params.sort == SortType.stars
            ? 1
            : _provider.params.sort == SortType.updated
                ? 2
                : 0,
        onSelected: (index) {
          if (_currentOption != index && index != null) {
            _currentOption = index;
            final sort = switch (index) {
              0 => null,
              1 => SortType.stars,
              _ => SortType.updated,
            };
            _provider.reset();
            _provider
                .updateParams(_provider.params.copyWith(sort: sort, page: 1));
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
