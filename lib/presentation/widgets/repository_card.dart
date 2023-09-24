import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_dart_repository/data/models/repository_model.dart';

class RepositoryCard extends StatelessWidget {
  final RepositoryModel model;
  final bool isSaved;

  const RepositoryCard({
    super.key,
    required this.model,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: model.owner.avatarUrl,
        width: 36,
        height: 36,
      ),
      title: Text(model.owner.login),
      subtitle: Text(model.htmlUrl),
      trailing: Icon(isSaved ? Icons.star : Icons.star_border),
      onTap: () {},
    );
  }
}
