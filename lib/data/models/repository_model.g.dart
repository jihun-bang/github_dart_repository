// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryModel _$RepositoryModelFromJson(Map<String, dynamic> json) =>
    RepositoryModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      owner: OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
      htmlUrl: json['html_url'] as String,
    );

Map<String, dynamic> _$RepositoryModelToJson(RepositoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'owner': instance.owner.toJson(),
      'html_url': instance.htmlUrl,
    };
