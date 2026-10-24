import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/home_product_entity.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  void loadHomeData() async {
    int categoryId = 0;
    emit(CategoriesLoading());
    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) => emit(CategoriesError(failure.failureMessage)),
      (categories) {
        categoryId = categories[0].id;
        emit(CategoriesSuccess(categories));
      },
    );

    final products = await getProductsUseCase.invoke(categoryId);
    products.fold((failure) => emit(ProductsError(failure.failureMessage)), (
      products,
    ) {
      emit(ProductsSuccess(products));
    });
  }

  void getProductsForCategory(int? categoryId) async {
    emit(ProductsLoading());
    final products = await getProductsUseCase.invoke(categoryId);
    products.fold((failure) => emit(ProductsError(failure.failureMessage)), (
      products,
    ) {
      emit(ProductsSuccess(products));
    });
  }
}
