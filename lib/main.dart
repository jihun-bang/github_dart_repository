import 'package:flutter/material.dart';
import 'package:github_dart_repository/dependencies_injection.dart';
import 'package:github_dart_repository/presentation/pages/repositories_page.dart';
import 'package:github_dart_repository/presentation/providers/github_provider.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GithubProvider>(create: (_) => sl()),
      ],
      child: MaterialApp(
        title: 'Github Dart Repositories',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: const RepositoriesPage(),
      ),
    );
  }
}
