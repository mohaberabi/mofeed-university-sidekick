import '../../utils/typdefs/typedefs.dart';

abstract class ApiClient {
  Future<dynamic> get(String path, {MapJson? queryParams});

  Future<dynamic> post(String path, {MapJson? queryParams, MapJson? body});

  Future<dynamic> put(String path, {MapJson? queryParams, MapJson? body});
}
