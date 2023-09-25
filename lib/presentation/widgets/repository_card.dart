import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_dart_repository/data/models/repository_model.dart';

class RepositoryCard extends StatelessWidget {
  final RepositoryModel model;
  final VoidCallback onTap;

  const RepositoryCard({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: model.owner.avatarUrl,
        width: 40,
        height: 40,
        errorWidget: (_, __, ___) => const Icon(Icons.person),
      ),
      title: Text(model.fullName),
      subtitle: Text(model.htmlUrl),
      trailing: Icon(model.isSaved ? Icons.star : Icons.star_border),
      onTap: onTap,
    );
  }
}
