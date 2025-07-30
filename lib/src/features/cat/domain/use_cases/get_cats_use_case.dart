import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:xpert_flutter/src/core/erros/erros.dart';
import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';

import '../repositories/cat_repository.dart';

class GetCatsUseCase {
  final CatRepository _catRepository;

  GetCatsUseCase(this._catRepository);

  Future<Either<ErrorModel, List<CatModel>>> call(BuildContext context) async {
    return await _catRepository.getCats(context);
  }
}
