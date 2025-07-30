import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';
import 'package:xpert_flutter/src/features/cat/domain/use_cases/get_cat_images_use_case.dart';
import 'package:xpert_flutter/src/features/cat/domain/use_cases/get_cats_use_case.dart';

part 'cat_state.dart';

class CatCubit extends Cubit<CatState> {
  final GetCatsUseCase _getCatsUseCase;
  final GetCatImagesUseCase _getCatImagesUseCase;

  CatCubit(this._getCatsUseCase, this._getCatImagesUseCase)
    : super(
        CatState(
          isLoading: false,
          selectedCat: '',
          cats: [],
          catImages: [],
          pageController: CarouselSliderController(),
        ),
      );

  void _showLoading({required bool isLoading}) {
    emit(state.copyWith(isLoading: isLoading));
  }

  void changeCat(BuildContext context, {required String selectedCat}) {
    if (state.cats.isNotEmpty) {
      CatModel cat = state.cats.firstWhere(
        (element) => element.id == selectedCat,
      );
      emit(state.copyWith(cat: cat));
    }

    emit(state.copyWith(selectedCat: selectedCat));
    getCatImages(context);
  }

  void setCats({required List<CatModel> cats}) {
    emit(state.copyWith(cats: cats));
  }

  void setCatImages({required List<CatImageModel> catImages}) {
    emit(state.copyWith(catImages: catImages));
  }

  void getCats(BuildContext context) async {
    _showLoading(isLoading: true);
    final result = await _getCatsUseCase.call(context);
    result.fold((error) {}, (response) {
      changeCat(context, selectedCat: response.first.id);
      setCats(cats: response);
    });
    _showLoading(isLoading: false);
  }

  void changeIndex(BuildContext context, {int newIndex = 0}) {
    List<CatModel> cats = state.cats;
    CatModel cat;
    if (cats.isNotEmpty) {
      cat = cats[newIndex];
      emit(state.copyWith(cat: cat, selectedCat: cat.id));
      if (cat.image == null) getCatImages(context, limit: 1);
    }
    emit(state.copyWith(currentIndex: newIndex));
  }

  void getCatImages(BuildContext context, {int? limit}) async {
    _showLoading(isLoading: true);
    final result = await _getCatImagesUseCase.call(
      context,
      catID: state.selectedCat,
      limit: limit,
    );
    result.fold((error) {}, (response) {
      CatModel? catTemp = state.cat;
      if (catTemp != null) {
        catTemp.setImage(response.first);
        emit(state.copyWith(cat: catTemp));
      }
      setCatImages(catImages: response);
    });
    _showLoading(isLoading: false);
  }
}
