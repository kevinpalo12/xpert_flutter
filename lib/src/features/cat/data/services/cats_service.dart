import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';

abstract class CatsService {
  Future<List<CatModel>> getCats(BuildContext context);
  Future<List<CatImageModel>> getImagesCat(
    BuildContext context, {
    required String catID,
  });
}

class CatsServiceImpl implements CatsService {
  final Dio _dio;

  CatsServiceImpl(this._dio);

  @override
  Future<List<CatModel>> getCats(BuildContext context) async {
    try {
      Map<String, dynamic> queryParams = {"limit": 100, "page": 0};

      var response = await _dio.get('breeds', queryParameters: queryParams);
      if (response.statusCode == 200) {
        List<CatModel> cats = [];
        if (response.data is List) {
          for (var cat in response.data) {
            cats.add(CatModel.fromJson(cat));
          }
        }
        return cats;
      } else {
        throw Exception('Error general, favor contactate con un administrador');
      }
    } on DioException catch (e) {
      throw DioException(error: "OSError", requestOptions: e.requestOptions);
    } on Exception {
      throw Exception();
    }
  }

  @override
  Future<List<CatImageModel>> getImagesCat(
    BuildContext context, {
    required String catID,
  }) async {
    try {
      Map<String, dynamic> queryParams = {
        "breed_ids": catID,
        "limit": 100,
        'api_key': dotenv.env['API_CATS'].toString(),
      };

      var response = await _dio.get(
        'https://api.thecatapi.com/v1/images/search',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        List<CatImageModel> cats = [];
        if (response.data is List) {
          for (var cat in response.data) {
            cats.add(CatImageModel.fromJson(cat));
          }
        }
        return cats;
      } else {
        throw Exception('Error general, favor contactate con un administrador');
      }
    } on DioException catch (e) {
      throw DioException(error: "OSError", requestOptions: e.requestOptions);
    } on Exception {
      throw Exception();
    }
  }
}
