import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_request_model.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class RepositoryRequestModel {
  final SortType? sort;
  final int perPage;
  final int page;

  const RepositoryRequestModel({
    this.sort,
    this.perPage = 20,
    this.page = 1,
  });

  factory RepositoryRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RepositoryRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryRequestModelToJson(this);
}

enum SortType { stars, updated }
