import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_dart_repository/dependencies_injection.dart';
import 'package:github_dart_repository/presentation/pages/home_page.dart';
import 'package:github_dart_repository/presentation/providers/github_provider.dart';
import 'package:provider/provider.dart';

const storage = FlutterSecureStorage();

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
        debugShowCheckedModeBanner: false,
        title: 'Github Dart Repositories',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
