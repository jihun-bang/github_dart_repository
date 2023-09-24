// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_request_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RepositoryRequestModelCWProxy {
  RepositoryRequestModel sort(SortType? sort);

  RepositoryRequestModel perPage(int perPage);

  RepositoryRequestModel page(int page);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RepositoryRequestModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RepositoryRequestModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RepositoryRequestModel call({
    SortType? sort,
    int? perPage,
    int? page,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRepositoryRequestModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRepositoryRequestModel.copyWith.fieldName(...)`
class _$RepositoryRequestModelCWProxyImpl
    implements _$RepositoryRequestModelCWProxy {
  const _$RepositoryRequestModelCWProxyImpl(this._value);

  final RepositoryRequestModel _value;

  @override
  RepositoryRequestModel sort(SortType? sort) => this(sort: sort);

  @override
  RepositoryRequestModel perPage(int perPage) => this(perPage: perPage);

  @override
  RepositoryRequestModel page(int page) => this(page: page);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RepositoryRequestModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RepositoryRequestModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RepositoryRequestModel call({
    Object? sort = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
  }) {
    return RepositoryRequestModel(
      sort: sort == const $CopyWithPlaceholder()
          ? _value.sort
          // ignore: cast_nullable_to_non_nullable
          : sort as SortType?,
      perPage: perPage == const $CopyWithPlaceholder() || perPage == null
          ? _value.perPage
          // ignore: cast_nullable_to_non_nullable
          : perPage as int,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
    );
  }
}

extension $RepositoryRequestModelCopyWith on RepositoryRequestModel {
  /// Returns a callable class that can be used as follows: `instanceOfRepositoryRequestModel.copyWith(...)` or like so:`instanceOfRepositoryRequestModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RepositoryRequestModelCWProxy get copyWith =>
      _$RepositoryRequestModelCWProxyImpl(this);
}

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
