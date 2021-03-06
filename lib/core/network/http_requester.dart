import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prozone_app/core/constants/endpoint_constants.dart';
import 'package:prozone_app/core/constants/env_constant.dart';

class HttpServiceRequester {
  final Dio dio;
  final DioCacheManager dioCacheManager;
  HttpServiceRequester({
    @required this.dio,
    @required this.dioCacheManager,
  });

  Future<Response> post({
    @required String url,
    dynamic body,
    @required String contentType,
    Map queryParam,
  }) async {
    dio.options.headers["Authorization"] = "Bearer ${env[AUTH_TOKEN]}";

    Response response = await dio.post(
      url,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        // headers: {headers,
        // followRedirects: true,
      ),
    );
    return response;
  }

  Future<Response> upload({
    @required String url,
    Map headers,
    @required dynamic body,
    @required contentType,
    Map queryParam,
  }) async {
    Response response = await dio.post(
      url,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        headers: headers,
      ),
    );
    return response;
  }

  Future<Response> getRequest({
    @required String url,
    Map<String, dynamic> queryParam,
  }) async {
    dio.options.headers["Authorization"] = "Bearer ${env[AUTH_TOKEN]}";
    Options _cacheOptions = buildCacheOptions(
      Duration(
        seconds: 1,
      ),
    );
    if (url != GET_PROVIDERS_ENDPOINT)
      _cacheOptions = buildCacheOptions(
        Duration(
          minutes: 20,
        ),
      );

    dio.interceptors.add(dioCacheManager.interceptor);

    Response response = await dio.get(
      url,
      options: _cacheOptions,
      queryParameters: queryParam,
    );
    return response;
  }

  Future<Response> delete({
    @required String url,
    Map headers,
    Map queryParam,
    @required contentType,
  }) async {
    dio.options.headers["Authorization"] = "Bearer ${env[AUTH_TOKEN]}";

    dio.options.headers = headers;
    Response response = await dio.delete(url,
        queryParameters: queryParam,
        options: Options(
          contentType: contentType,
          headers: headers,
        ));
    return response;
  }

  Future<Response> put({
    @required String url,
    @required Map data,
    @required contentType,
  }) async {
    dio.options.headers["Authorization"] = "Bearer ${env[AUTH_TOKEN]}";
    Response response = await dio.put(
      url,
      data: data,
      // queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        // headers: {headers,
        // followRedirects: true,
      ),
    );
    return response;
  }
}
