import 'package:json_annotation/json_annotation.dart';

import 'owner_model.dart';

part 'repository_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class RepositoryModel {
  final int id;
  final String fullName;
  final OwnerModel owner;
  final String htmlUrl;

  const RepositoryModel({
    required this.id,
    required this.fullName,
    required this.owner,
    required this.htmlUrl,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) =>
      _$RepositoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryModelToJson(this);
}
