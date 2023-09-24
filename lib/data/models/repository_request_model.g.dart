// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryRequestModel _$RepositoryRequestModelFromJson(
        Map<String, dynamic> json) =>
    RepositoryRequestModel(
      sort: $enumDecodeNullable(_$SortTypeEnumMap, json['sort']),
      perPage: json['per_page'] as int? ?? 20,
      page: json['page'] as int? ?? 1,
    );

Map<String, dynamic> _$RepositoryRequestModelToJson(
        RepositoryRequestModel instance) =>
    <String, dynamic>{
      'sort': _$SortTypeEnumMap[instance.sort],
      'per_page': instance.perPage,
      'page': instance.page,
    };

const _$SortTypeEnumMap = {
  SortType.stars: 'stars',
  SortType.updated: 'updated',
};
