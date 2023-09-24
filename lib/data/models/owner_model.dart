import 'package:json_annotation/json_annotation.dart';

part 'owner_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OwnerModel {
  final String login;
  final String avatarUrl;

  const OwnerModel({
    required this.login,
    required this.avatarUrl,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}
