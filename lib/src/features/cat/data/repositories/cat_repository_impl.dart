import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:xpert_flutter/src/core/erros/erros.dart';

import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';

import '../services/cats_service.dart';

import '../../domain/repositories/cat_repository.dart';

class CatRepositoryImpl implements CatRepository {
  final CatsService _catsService;

  CatRepositoryImpl(this._catsService);

  @override
  Future<Either<ErrorModel, List<CatModel>>> getCats(
    BuildContext context,
  ) async {
    try {
      return Right(await _catsService.getCats(context));
    } on DioException catch (e) {
      if (e.error == "OSError") {
        return Left(ErrorModel(code: 'Dio'));
      } else {
        return Left(ErrorModel(code: 'xxx'));
      }
    }
  }

  @override
  Future<Either<ErrorModel, List<CatImageModel>>> getImagesCat(
    BuildContext context, {
    int? limit,
    required String catID,
  }) async {
    try {
      return Right(
        await _catsService.getImagesCat(context, catID: catID, limit: limit),
      );
    } on DioException catch (e) {
      if (e.error == "OSError") {
        return Left(ErrorModel(code: 'Dio'));
      } else {
        return Left(ErrorModel(code: 'xxx'));
      }
    }
  }
}
