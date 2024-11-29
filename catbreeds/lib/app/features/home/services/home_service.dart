import 'package:catbreeds/app/config/api/api.dart';
import 'package:catbreeds/app/features/home/models/catbreed_model.dart';
import 'package:catbreeds/app/features/shared/models/service_exception.dart';
import 'package:dio/dio.dart';

class HomeService {
  static Future<List<CatbreedResponse>> getData() async {
    try {
      final response = await Api().get('breeds');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => CatbreedResponse.fromJson(json))
            .toList();
      } else {
        throw ServiceException(
            response.statusMessage, 'Hubo un error al obtener los datos');
      }
    } on DioException catch (e) {
      throw ServiceException(e, 'Hubo un error en la conexión.');
    } catch (e) {
      throw ServiceException(e, 'Algo salió mal.');
    }
  }
}
