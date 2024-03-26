// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/helpers/date_helper.dart';
import 'package:human_resource_management_system/core/helpers/token_helper.dart';
import 'http_config.dart';

class HttpApiService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 500000),
    receiveTimeout: const Duration(milliseconds: 500000),
    headers: HttpConfig.headers,
  ));

  final Dio _tokenDio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 500000),
    receiveTimeout: const Duration(milliseconds: 500000),
    headers: HttpConfig.headers,
  ));

  HttpApiService() {
    _setupInterceptors();
    _setupTokenInterceptors();
  }

  Dio getDio() => _dio;
  Dio getSimpleDio() => _tokenDio;

  /// Handy method to make http GET request, which is a alias of [Dio.request].
  Future<Response> get(String endpoint, Map<String, dynamic>? queryParams, Options options) async {
    //try {
    String urlEndpoint = _buildUrl(endpoint);
    Response response = await _dio.get(urlEndpoint, queryParameters: queryParams, options: options);
    return response;
    // } on DioError catch (e) {
    //   assert(e.response.statusCode == 404);
    // }
  }

  /// Handy method to make http POST request, which is a alias of [Dio.request].
  Future<Response> post(String endpoint, dynamic postData, Map<String, dynamic>? queryParams, Options options) async {
    // try {
    String urlEndpoint = _buildUrl(endpoint);
    Response response = await _dio.post(urlEndpoint, data: postData, queryParameters: queryParams, options: options);
    return response;
    //
  }

  /// Handy method to make http PUT request, which is a alias of [Dio.request].
  Future<Response> put(String endpoint, dynamic putData, Map<String, dynamic>? queryParams, Options options) async {
    //try {
    String urlEndpoint = _buildUrl(endpoint);
    Response response = await _dio.put(urlEndpoint, data: putData, queryParameters: queryParams, options: options);
    return response;
    // } on DioError catch (e) {
    //   assert(e.response.statusCode == 404);
    // }
  }

  /// Handy method to make http DELETE request, which is a alias of  [Dio.request].
  Future<Response> delete(String endpoint, dynamic deleteData, Map<String, dynamic>? queryParams, Options options) async {
    //try {
    String urlEndpoint = _buildUrl(endpoint);
    Response response = await _dio.delete(urlEndpoint, data: deleteData, queryParameters: queryParams, options: options);
    return response;
    // } on DioError catch (e) {
    //   print(e.message);
    //   assert(e.response.statusCode == 404);
    // }
  }

  /// Download the file and save it in local. The default http method is "GET",
  //Future download(String urlPath, savePath, {ProgressCallback onReceiveProgress, Map<String, dynamic> queryParameters, CancelToken cancelToken, lengthHeader = HttpHeaders.contentLengthHeader, data, Options options}) async {
  //try {
  //Uri uri = buildUri(endpoint, queryParams);
  //Response response = await _dio.download(urlPath, savePath);
  //return response;
  // } on DioError catch (e) {
  //   assert(e.response.statusCode == 404);
  // }
  //}

  // Setup Interceptor
  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      String? accessToken = TokenHelper.getInstance().getAccessToken();
      if (accessToken != null && accessToken != '') {
        // if (TokenHelper.getInstance().isTokenExpire()) {
        //   _dio.lock();
        //   return authService.authRefresh().then((success) {
        //     accessToken = TokenHelper.getInstance().getAccessToken();
        //     options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + accessToken;
        //     return options;
        //   }).whenComplete(() {
        //     _dio.unlock();
        //   });
        // } else {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
        // }
      } else {
        options.headers[HttpHeaders.authorizationHeader] = HttpConfig.getInstance().getApiSecredKey();
      }

      options.headers["app-version"] = TokenHelper.getInstance().getAppVersion();
      options.headers[HttpConfig.CLIENT_GATEWAY_CODE] = TokenHelper.getInstance().getKey(HttpConfig.CLIENT_GATEWAY_CODE);

      print("--> ");
      print("--> ");
      print("--> RequestOptions: ${DateHelper.format(DateTime.now(), DateHelper.timeFormatddMMyyyHHMMSSA)}");
      print("--> ${options.method} ${options.path}");
      // print("--> Headers: ${options.headers}");
      print("--> Datas: ${options.data}");
      // print("--> QueryParams: ${options.queryParameters}");
      // print("--> Content type: ${options.contentType}");
      // print("<-- END RequestOptions");
      print("--> ");
      print("--> ");

      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      print("<-- ");
      print("<-- ");
      print("<-- Response: ${DateHelper.format(DateTime.now(), DateHelper.timeFormatddMMyyyHHMMSSA)}");
      print("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
      //String responseAsString = response.data.toString();
      print(response.data);
      print("<-- END Response HTTP");
      print("<--");
      print("<--");
      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      print("<--> ");
      print("<--> ");
      print("<--> Request/Response ERROR:");
      print("<--> ");
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print("<--> Headers: ${e.response!.headers}");
        print("<--> Datas: ${e.response!.data}");
        print("<--> Request: ${e.response!.requestOptions}");
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print("<--> Request: ${e.requestOptions}");
        print("<--> Message: ${e.message}");
      }
      print("<--> ");
      print("<--> End Request/Response ERROR");
      print("<--> ");
      print("<--> ");
      return handler.next(e); //continue
    }));
  }

  // Setup Interceptor
  void _setupTokenInterceptors() {
    _tokenDio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      print("<- TOKEN DIO-> ");
      print("--> ");
      print("--> ");
      print("--> RequestOptions: ${DateHelper.format(DateTime.now(), DateHelper.timeFormatddMMyyyHHMMSSA)}");
      // print("--> ${options.method} ${options.path}");
      // print("--> Headers: ${options.headers}");
      // print("--> Datas: ${options.data}");
      // print("--> QueryParams: ${options.queryParameters}");
      // print("--> Content type: ${options.contentType}");
      print("<-- END RequestOptions");
      print("--> ");
      print("--> ");
      print("<- TOKEN DIO-> ");

      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      print("<- TOKEN DIO-> ");
      print("<-- ");
      print("<-- ");
      print("<-- Response: ${DateHelper.format(DateTime.now(), DateHelper.timeFormatddMMyyyHHMMSSA)}");
      print("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
      //String responseAsString = response.data.toString();
      //print(response.data);
      print("<-- END Response HTTP");
      print("<--");
      print("<--");
      print("<- TOKEN DIO-> ");
      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      print("<- TOKEN DIO-> ");
      print("<--> ");
      print("<--> ");
      print("<--> Request/Response ERROR:");
      print("<--> ");
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print("<--> Headers: ${e.response!.headers}");
        print("<--> Datas: ${e.response!.data}");
        print("<--> Request: ${e.response!.requestOptions}");
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print("<--> Request: ${e.requestOptions}");
        print("<--> Message: ${e.message}");
      }
      print("<--> ");
      print("<--> End Request/Response ERROR");
      print("<--> ");
      print("<--> ");
      print("<- TOKEN DIO-> ");
      return handler.next(e); //continue
    }));
  }

  String _buildUrl(String endPoint) {
    String baseUrl = HttpConfig.getInstance().getBaseApiClientUrl() ?? '';
    return baseUrl + endPoint;
  }
}
