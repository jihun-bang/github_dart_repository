import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:github_dart_repository/presentation/providers/github_provider.dart';
import 'package:github_dart_repository/presentation/widgets/repository_card.dart';
import 'package:provider/provider.dart';

import '../../dependencies_injection.dart';

class RepositoriesOfflinePage extends StatefulWidget {
  const RepositoriesOfflinePage({super.key});

  @override
  State<RepositoriesOfflinePage> createState() =>
      _RepositoriesOfflinePageState();
}

class _RepositoriesOfflinePageState extends State<RepositoriesOfflinePage> {
  late GithubProvider _provider;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _provider.getModels(local: true);
      _subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        final isOffline = result == ConnectivityResult.none;
        if (isOffline) {
          _provider.getModels(local: true);
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GithubProvider>(
      create: (_) {
        _provider = sl<GithubProvider>();
        return _provider;
      },
      child: Consumer<GithubProvider>(builder: (_, provider, ___) {
        return SafeArea(child: repositories);
      }),
    );
  }

  Widget get repositories {
    return _provider.models.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              final item = _provider.models[index];
              return RepositoryCard(
                model: item,
                onTap: () {
                  _provider.save(item);
                },
              );
            },
            itemCount: _provider.models.length,
            separatorBuilder: (_, __) => const Divider(),
          )
        : const Center(
            child: Text('No Data'),
          );
  }
}
