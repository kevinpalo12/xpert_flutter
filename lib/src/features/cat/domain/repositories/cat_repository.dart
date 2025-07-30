import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:xpert_flutter/src/core/erros/erros.dart';
import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';

abstract class CatRepository {
  Future<Either<ErrorModel, List<CatModel>>> getCats(BuildContext context);
  Future<Either<ErrorModel, List<CatImageModel>>> getImagesCat(
    BuildContext context, {
    required String catID,
  });
}
