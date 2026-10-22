part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class CategoriesLoading extends HomeState {}

final class CategoriesSuccess extends HomeState {
  final List<CategoryModel> categories;
  CategoriesSuccess(this.categories);
}

final class CategoriesError extends HomeState {
  final String errorMessage;
  CategoriesError(this.errorMessage);
}

final class ProductsLoading extends HomeState {}

final class ProductsSuccess extends HomeState {
  final List<ProductModel> products;
  ProductsSuccess(this.products);
}

final class ProductsError extends HomeState {
  final String errorMessage;
  ProductsError(this.errorMessage);
}
