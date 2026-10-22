import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/home_service.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial());

  void loadHomeData() async {
    emit(CategoriesLoading());
    try {
      final categories = await homeService.getCategories();
      emit(CategoriesSuccess(categories));
      if (categories.isNotEmpty) {
        final products = await homeService.getProducts(categories[0].id);
        emit(ProductsSuccess(products));
      } else {
        emit(ProductsSuccess([]));
      }
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void getProductsForCategory(int? categoryId) async {
    emit(ProductsLoading());
    try {
      final products = await homeService.getProducts(categoryId);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
