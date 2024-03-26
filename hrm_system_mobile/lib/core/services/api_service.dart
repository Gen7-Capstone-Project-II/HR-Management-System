import 'package:dio/dio.dart';

const fileBaseUrl = "https://hrm-system-test.up.railway.app/";

class ApiService {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://hrm-system-test.up.railway.app/api/',
      sendTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 50000),
      connectTimeout: const Duration(milliseconds: 50000),
    ),
  )..interceptors.add(LogInterceptor());
}