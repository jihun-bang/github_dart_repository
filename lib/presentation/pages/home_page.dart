import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:github_dart_repository/core/utils/logger.dart';
import 'package:github_dart_repository/presentation/pages/repositories_offline_page.dart';
import 'package:github_dart_repository/presentation/pages/repositories_online_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOffline = false;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        _isOffline = connectivityResult == ConnectivityResult.none;
      });

      _subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        final isOffline = result == ConnectivityResult.none;
        setState(() {
          _isOffline = isOffline;
        });
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
    Logger.d(_isOffline);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              Text('Dart Repositories (${_isOffline ? 'Offline' : 'Online'})'),
        ),
        body: IndexedStack(
          index: _isOffline ? 0 : 1,
          children: const [
            RepositoriesOfflinePage(),
            RepositoriesOnlinePage(),
          ],
        ));
  }
}
