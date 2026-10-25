import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/home_product_entity.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  static const int _limit = 10;
  int _offset = 0;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int? currentCategoryId;
  final List<HomeCategoryEntity> _categories = [];
  final List<HomeProductEntity> _products = [];

  List<HomeCategoryEntity> get categories => List.unmodifiable(_categories);
  List<HomeProductEntity> get products => List.unmodifiable(_products);

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  void loadHomeData() async {
    if (_categories.isNotEmpty && _products.isNotEmpty) {
      emit(CategoriesSuccess(_categories));
      emit(ProductsSuccess(_products));
      return;
    }
    emit(CategoriesLoading());
    final categoriesResult = await getCategoriesUseCase.invoke();
    categoriesResult.fold(
      (failure) => emit(CategoriesError(failure.failureMessage)),
      (categories) {
        _categories.clear();
        _categories.addAll(categories);
        emit(CategoriesSuccess(categories));
        if (categories.isNotEmpty) {
          getProductsForCategory(categories[0].id);
        } else {
          emit(ProductsSuccess([]));
        }
      },
    );
  }

  void getProductsForCategory(int? categoryId) {
    currentCategoryId = categoryId;
    _products.clear();
    _offset = 0;
    _hasMore = true;
    _isLoadingMore = false;
    emit(ProductsLoading());
    _fetchProducts();
  }

  Future<void> loadMoreProducts() async {
    if (!_hasMore || _isLoadingMore) return;
    _isLoadingMore = true;
    emit(ProductLoadingMoreLoading());
    await _fetchProducts(isLoadingMore: true);
    _isLoadingMore = false;
  }

  Future<void> _fetchProducts({bool isLoadingMore = false}) async {
    final result = await getProductsUseCase.invoke(
      currentCategoryId,
      limit: _limit,
      offset: _offset,
    );

    result.fold(
      (failure) {
        if (isLoadingMore) {
          emit(ProductLoadingMoreError(failure.failureMessage));
        } else {
          emit(ProductsError(failure.failureMessage));
        }
      },
      (newProducts) {
        _products.addAll(newProducts);
        _offset += newProducts.length;
        if (newProducts.length < _limit) {
          _hasMore = false;
        }
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }
}
