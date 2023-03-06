import 'utils.dart';
import 'base_url.dart';
import 'package:dio/dio.dart';

Dio get dio => Dio(_baseOption)..interceptors.add(_interceptor);

Duration get _timeOut => const Duration(seconds: 15);

BaseOptions get _baseOption => BaseOptions(
      queryParameters: {"key": const String.fromEnvironment('API_KEY')},
      baseUrl: baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
    );

InterceptorsWrapper get _interceptor => InterceptorsWrapper(
      onRequest: (options, handler) {
        printData("REQUEST path: ${options.path}");
        printData("REQUEST data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (e, handler) {
        printData("RESPONSE realUri: ${e.realUri}");
        printData("RESPONSE data: ${e.data}");
        return handler.next(e);
      },
      onError: (e, handler) {
        printData("ERROR error: ${e.error}");
        printData("ERROR message: ${e.message}");
        return handler.next(e); //continue
      },
    );
