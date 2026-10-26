import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/use_cases/get_product_details_use_case.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  DetailsCubit({required this.getProductDetailsUseCase})
      : super(DetailsInitial());

  void loadProductDetails(int productId) async {
    emit(DetailsLoading());
    final result = await getProductDetailsUseCase.invoke(productId);
    result.fold(
      (failure) => emit(DetailsError(failure.failureMessage)),
      (productDetails) => emit(DetailsSuccess(productDetails)),
    );
  }
}
