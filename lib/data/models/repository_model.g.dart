// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RepositoryModelCWProxy {
  RepositoryModel id(int id);

  RepositoryModel fullName(String fullName);

  RepositoryModel owner(OwnerModel owner);

  RepositoryModel htmlUrl(String htmlUrl);

  RepositoryModel isSaved(bool isSaved);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RepositoryModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RepositoryModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RepositoryModel call({
    int? id,
    String? fullName,
    OwnerModel? owner,
    String? htmlUrl,
    bool? isSaved,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRepositoryModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRepositoryModel.copyWith.fieldName(...)`
class _$RepositoryModelCWProxyImpl implements _$RepositoryModelCWProxy {
  const _$RepositoryModelCWProxyImpl(this._value);

  final RepositoryModel _value;

  @override
  RepositoryModel id(int id) => this(id: id);

  @override
  RepositoryModel fullName(String fullName) => this(fullName: fullName);

  @override
  RepositoryModel owner(OwnerModel owner) => this(owner: owner);

  @override
  RepositoryModel htmlUrl(String htmlUrl) => this(htmlUrl: htmlUrl);

  @override
  RepositoryModel isSaved(bool isSaved) => this(isSaved: isSaved);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RepositoryModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RepositoryModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RepositoryModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? owner = const $CopyWithPlaceholder(),
    Object? htmlUrl = const $CopyWithPlaceholder(),
    Object? isSaved = const $CopyWithPlaceholder(),
  }) {
    return RepositoryModel(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      fullName: fullName == const $CopyWithPlaceholder() || fullName == null
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String,
      owner: owner == const $CopyWithPlaceholder() || owner == null
          ? _value.owner
          // ignore: cast_nullable_to_non_nullable
          : owner as OwnerModel,
      htmlUrl: htmlUrl == const $CopyWithPlaceholder() || htmlUrl == null
          ? _value.htmlUrl
          // ignore: cast_nullable_to_non_nullable
          : htmlUrl as String,
      isSaved: isSaved == const $CopyWithPlaceholder() || isSaved == null
          ? _value.isSaved
          // ignore: cast_nullable_to_non_nullable
          : isSaved as bool,
    );
  }
}

extension $RepositoryModelCopyWith on RepositoryModel {
  /// Returns a callable class that can be used as follows: `instanceOfRepositoryModel.copyWith(...)` or like so:`instanceOfRepositoryModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RepositoryModelCWProxy get copyWith => _$RepositoryModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryModel _$RepositoryModelFromJson(Map<String, dynamic> json) =>
    RepositoryModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      owner: OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
      htmlUrl: json['html_url'] as String,
      isSaved: json['is_saved'] as bool? ?? false,
    );

Map<String, dynamic> _$RepositoryModelToJson(RepositoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'owner': instance.owner.toJson(),
      'html_url': instance.htmlUrl,
      'is_saved': instance.isSaved,
    };
