import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:xpert_flutter/src/features/cat/cubit/cat_cubit.dart';
import 'package:xpert_flutter/src/features/cat/data/repositories/cat_repository_impl.dart';
import 'package:xpert_flutter/src/features/cat/data/services/cats_service.dart';
import 'package:xpert_flutter/src/features/cat/domain/repositories/cat_repository.dart';
import 'package:xpert_flutter/src/features/cat/domain/use_cases/get_cat_images_use_case.dart';
import 'package:xpert_flutter/src/features/cat/domain/use_cases/get_cats_use_case.dart';

final sl = GetIt.instance;

class Dependencies {
  Future<void> setup() async {
    _registerBlocs();
    _registerRepositories();
    _registerUseCases();
    _registerDio();
    _registerDataSources();
  }

  Future<void> _registerBlocs() async {
    sl.registerFactory<CatCubit>(() => CatCubit(sl(), sl()));
  }

  Future<void> _registerRepositories() async {
    sl.registerLazySingleton<CatRepository>(() => CatRepositoryImpl(sl()));
  }

  Future<void> _registerUseCases() async {
    sl.registerLazySingleton(() => GetCatsUseCase(sl()));
    sl.registerLazySingleton(() => GetCatImagesUseCase(sl()));
  }

  Future<void> _registerDataSources() async {
    sl.registerLazySingleton<CatsService>(
      () => CatsServiceImpl(sl(instanceName: 'dio')),
    );
  }

  static Future<void> tokenSetup(String token) async {
    final dio = sl<Dio>(instanceName: 'dio');

    dio.options.headers["Authorization"] = "Bearer $token";
  }

  void _registerDio() {
    sl.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: dotenv.env['API_URL'].toString(),
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      ),
      instanceName: 'dio',
    );
  }
}
