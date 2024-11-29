import 'package:catbreeds/app/config/constants/environment.dart';
import 'package:dio/dio.dart';

class Api {
  final Dio _dioBase = Dio(BaseOptions(baseUrl: Environment.urlBase));

  InterceptorsWrapper interceptor = InterceptorsWrapper();

  Api() {
    interceptor = InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          //api key brindada en el pdf
          options.headers['x-api-key'] = 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr';
          options.headers['Accept'] = 'aplication/json';
          handler.next(options);
        } catch (e) {
          handler.reject(DioException(
            requestOptions: options,
            error: e,
          ));
        }
      },
    );
    _dioBase.interceptors.add(interceptor);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioBase.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {required Object data}) async {
    return _dioBase.post(path, data: data);
  }

  Future<Response> delete(String path, {required Object data}) async {
    return _dioBase.delete(path, data: data);
  }
}
