part of 'cat_cubit.dart';

class CatState extends Equatable {
  final bool isLoading;
  final String? error;
  final String selectedCat;
  final List<CatModel> cats;
  final List<CatImageModel> catImages;
  final CatModel? cat;

  const CatState({
    this.isLoading = false,
    this.error,
    required this.selectedCat,
    required this.cats,
    required this.catImages,
    this.cat,
  });

  @override
  List<Object> get props => [
    isLoading,
    error ?? "",
    selectedCat,
    cats,
    catImages,
    cat ?? '',
  ];

  CatState copyWith({
    bool? isLoading,
    String? error,
    String? selectedCat,
    List<CatModel>? cats,
    List<CatImageModel>? catImages,
    CatModel? cat,
  }) {
    return CatState(
      cat: cat ?? this.cat,
      catImages: catImages ?? this.catImages,
      cats: cats ?? this.cats,
      selectedCat: selectedCat ?? this.selectedCat,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
