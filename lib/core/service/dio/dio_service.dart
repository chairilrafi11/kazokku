import 'dart:io';
import 'package:chairil/core/app/app_config.dart';
import 'package:chairil/core/app/env.dart';
import 'package:chairil/core/core_function.dart';
import 'package:chairil/domain/models/error_response.dart';
import 'package:chairil/presentations/component/dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_client.dart';

class DioService {
  static final DioService _singleton = DioService._internal();

  factory DioService() {
    return _singleton;
  }

  DioService._internal();

  static late Dio dio;

  static late DioClient dioClient;

  static Future<Dio> checkConnection({
    bool showMessage = true,
    bool isLoading = false,
    bool isProvince = false,
    bool isToken = false,
    required dynamic tryAgainMethod,
    dynamic stopLoadingMethod,
    List<dynamic>? params,
  }) async {
    if (isLoading) {
      ComponentDialog.loading();
    }
    return await CoreFunction.checkConnectivity().then((internet) async {
      if (internet) {
        return await settingUpDio(
          showMessage: showMessage,
          isLoading: isLoading,
          params: params,
          tryAgainMethod: tryAgainMethod,
          stopLoadingMethod: stopLoadingMethod,
          isToken: isToken,
          // ignore: body_might_complete_normally_catch_error
        ).catchError((e) {
          CoreFunction.logPrint('catchError error catched settingUpDio', e.toString());
        });
      } else {
        if (isLoading) {
          // BotToast.closeAllLoading();
        }
        CoreFunction.toast("Tidak dapat terhubung", "Pastikan handphone anda memiliki koneksi internet");
        return Dio();
      }
    });
  }

  static Future<Dio> settingUpDio({
    bool showMessage = true,
    bool isLoading = false,
    bool isToken = false,
    dynamic tryAgainMethod,
    dynamic stopLoadingMethod,
    dynamic params,
  }) async {
    dio = Dio(await baseOptions(isToken));

    try {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions? requestOptions, handler) async {
            CoreFunction.logPrint("============= onRequest =============", "");
            handler.next(requestOptions!);
          },
          onResponse: (Response? response, handler) async {
            if (isLoading) {
              // BotToast.closeAllLoading();
            }

            CoreFunction.logPrint("============= onResponse =============", "");

            handler.next(response!);
            if (response!.statusCode == 200) {
              // ResponseApiV2 responseApi = ResponseApiV2.fromJson(jsonDecode(response.toString()));
              // if (responseApi.success ?? true) {
              // handler.next(response);
              // } else {
              //   ErrorResponse errorResponse = ErrorResponse.fromJson(response.data);
              //   ErrorHandlingResponse(errors: errorResponse.errors!.first, showMessage: showMessage).checkErrror();
              //   handler.reject(
              //     DioException(
              //       requestOptions: RequestOptions(path: ''),
              //       response: Response(
              //         requestOptions: RequestOptions(path: ''),
              //         statusCode: errorResponse.code,
              //         data: "data",
              //         statusMessage: errorResponse.message,
              //       ),
              //     ),
              //   );
              //   return Future.error(Exception('e'));
              //   // handler.next(response);
              // }
            } else {
              ErrorResponse errorResponse = ErrorResponse.fromJson(response.data);
              // ErrorHandlingResponse(errors: errorResponse.errors!.first).checkErrror();
              // handler.reject(DioError(requestOptions: RequestOptions(path: '')));
              return Future.error(Exception());
            }
          },
          onError: (DioError e, handler) async {
            CoreFunction.logPrint("============= onError =============", "");

            CoreFunction.logPrint("Error Response", e.response);

            if (isLoading) {
              // BotToast.closeAllLoading();
            }

            //? Stop Loading From Layout
            if (stopLoadingMethod != null) stopLoadingMethod();

            if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout) {
              CoreFunction.toast("Request Time Out", "Pastikan handphone anda memiliki koneksi internet");
            } else if (e.type == DioExceptionType.unknown) {
              CoreFunction.toast("Tidak dapat terhubung", "Pastikan handphone anda memiliki koneksi internet");
            } else if (e.type == DioExceptionType.badResponse) {
              CoreFunction.logPrint("Error Data", e.response.toString());
              ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data);
              // if (!(errorResponse.success ?? false)) {
              //   if (errorResponse.code != null) {
              // ErrorHandlingResponse(
              //   errorResponse: errorResponse,
              //   showMessage: showMessage,
              // ).checkErrror();
              //   } else {
              //     ErrorHandlingResponse(errors: errorResponse.errors!.last, showMessage: showMessage).checkErrror();
              //   }
              // }
            }

            handler.next(e);
            throw e.error!;
          },
        ),
      );
    } catch (e) {
      CoreFunction.logPrint('rethrowing error', e.toString());
      rethrow;
    }

    dio.interceptors.add(
      PrettyDioLogger(
        error: AppConfig.debug,
        request: AppConfig.debug,
        requestBody: AppConfig.debug,
        requestHeader: AppConfig.debug,
        responseBody: AppConfig.debug,
        responseHeader: AppConfig.debug,
        compact: AppConfig.debug,
        maxWidth: 500,
      ),
    );

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    //   return client;
    // };

    if (!kIsWeb) {
      // ignore: deprecated_member_use
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    return dio;
  }

  static setupDio({bool isToken = false, bool showMessage = false}) async {
    dioClient = DioClient(await settingUpDio(isToken: isToken));
  }

  static Future<BaseOptions> baseOptions(bool isToken) async {
    return BaseOptions(
        baseUrl: baseURL(AppConfig.production),
        connectTimeout: AppConfig.timeRequestApi,
        receiveTimeout: AppConfig.timeRequestApi,
        sendTimeout: AppConfig.timeRequestApi,
        headers: {'Cache-Control': AppConfig.cacheControl, 'Content-Type': AppConfig.contentType, 'app-id': CoreFunction.getEnv(ENV.appId)});
  }

  static String baseURL(bool isProduction) {
    return CoreFunction.getEnv(ENV.url);
  }
}
