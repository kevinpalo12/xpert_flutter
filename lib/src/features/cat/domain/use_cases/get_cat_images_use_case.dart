import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:xpert_flutter/src/core/erros/erros.dart';
import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';

import '../repositories/cat_repository.dart';

class GetCatImagesUseCase {
  final CatRepository _catRepository;

  GetCatImagesUseCase(this._catRepository);

  Future<Either<ErrorModel, List<CatImageModel>>> call(
    BuildContext context, {
    required String catID,
    int? limit,
  }) async {
    return await _catRepository.getImagesCat(
      context,
      catID: catID,
      limit: limit,
    );
  }
}
