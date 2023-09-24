import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_dart_repository/core/constant.dart';

import '../error/failure.dart';
import 'dio_interceptor.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = _createDio();
    _dio.interceptors.add(DioInterceptor());
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: Constant.githubApiBaseUrl,
          headers: {
            'Authorization': 'Bearer ${Constant.githubToken}',
            'Accept': 'application/vnd.github+json',
          },
          receiveTimeout: const Duration(seconds: 20),
          connectTimeout: const Duration(seconds: 20),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      return Right(converter(response.data));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'] ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      return Right(converter(response.data));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'] ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> deleteRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      return Right(converter(response.data));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'] ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> putRequest<T>(
    String url, {
    dynamic data,
    required ResponseConverter<T> converter,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      return Right(converter(response.data));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'] ?? e.message,
        ),
      );
    }
  }
}
