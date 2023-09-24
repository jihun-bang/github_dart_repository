import 'package:flutter/material.dart';
import 'package:github_dart_repository/presentation/providers/github_provider.dart';
import 'package:github_dart_repository/presentation/widgets/repository_card.dart';
import 'package:provider/provider.dart';

class RepositoriesPage extends StatefulWidget {
  const RepositoriesPage({super.key});

  @override
  State<RepositoriesPage> createState() => _RepositoriesPageState();
}

class _RepositoriesPageState extends State<RepositoriesPage> {
  late GithubProvider _provider;

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: const Icon(Icons.refresh),
        ), //
      );
    });
  }

  Widget get repositories {
    return ListView.separated(
        itemBuilder: (_, index) {
          return RepositoryCard(model: _provider.models[index], isSaved: false);
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: _provider.models.length);
  }
}
