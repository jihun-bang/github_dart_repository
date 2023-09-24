import 'package:flutter/material.dart';
import 'package:github_dart_repository/data/models/owner_model.dart';
import 'package:github_dart_repository/data/models/repository_model.dart';
import 'package:github_dart_repository/presentation/widgets/repository_card.dart';

class RepositoriesPage extends StatefulWidget {
  const RepositoriesPage({super.key});

  @override
  State<RepositoriesPage> createState() => _RepositoriesPageState();
}

class _RepositoriesPageState extends State<RepositoriesPage> {
  @override
  Widget build(BuildContext context) {
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
  }

  Widget get repositories {
    return ListView.separated(
        itemBuilder: (_, __) {
          return RepositoryCard(
              model: RepositoryModel(
                id: 1,
                htmlUrl:
                    'https://api.flutter.dev/flutter/material/ListTile-class.html',
                fullName: 'fullName',
                owner: OwnerModel(login: 'testUser', avatarUrl: ''),
              ),
              isSaved: false);
        },
        separatorBuilder: (_, __) => Divider(),
        itemCount: 10);
  }
}
