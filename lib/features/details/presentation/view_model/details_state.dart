part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsSuccess extends DetailsState {
  final ProductDetailsEntity productDetails;
  DetailsSuccess(this.productDetails);
}

final class DetailsError extends DetailsState {
  final String errorMessage;
  DetailsError(this.errorMessage);
}
