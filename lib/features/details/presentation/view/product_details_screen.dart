import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/domain/entities/home_product_entity.dart';
import '../../../main_navigation/screens/main_navigation_screen.dart';
import '../../data/data_source/details_remote_data_source_imp.dart';
import '../../data/repository/details_repository_imp.dart';
import '../../domain/use_cases/get_product_details_use_case.dart';
import '../view_model/details_cubit.dart';
import 'widgets/color_selector.dart';
import 'widgets/share_product_button.dart';
import 'widgets/size_selector.dart';

class ProductDetailsScreen extends StatelessWidget {
  final HomeProductEntity? product;
  final int? productId;

  const ProductDetailsScreen({super.key, this.product, this.productId});

  @override
  Widget build(BuildContext context) {
    final effectiveId = product?.id ?? productId ?? 0;
    final apiClient = ApiClient();
    final remoteDataSource = DetailsRemoteDataSourceImp(apiClient);
    final repository = DetailsRepositoryImp(remoteDataSource);
    final getProductDetailsUseCase = GetProductDetailsUseCase(repository);

    return BlocProvider(
      create: (context) =>
          DetailsCubit(getProductDetailsUseCase: getProductDetailsUseCase)
            ..loadProductDetails(effectiveId),
      child: _ProductDetailsContent(
        initialProduct: product ?? HomeProductEntity(id: effectiveId),
      ),
    );
  }
}

class _ProductDetailsContent extends StatefulWidget {
  final HomeProductEntity initialProduct;

  const _ProductDetailsContent({required this.initialProduct});

  @override
  State<_ProductDetailsContent> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<_ProductDetailsContent> {
  Color? _selectedColor;
  String? _selectedSize;

  void _handleBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.canPop(context),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack(context);
      },
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading && widget.initialProduct.title.isEmpty) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is DetailsError &&
                widget.initialProduct.title.isEmpty) {
              return Scaffold(body: Center(child: Text(state.errorMessage)));
            }

            final HomeProductEntity currentProduct = state is DetailsSuccess
                ? state.productDetails
                : widget.initialProduct;

            _selectedColor ??= currentProduct.colors.isNotEmpty
                ? currentProduct.colors.first
                : Colors.black;
            _selectedSize ??= currentProduct.sizes.isNotEmpty
                ? currentProduct.sizes.first
                : 'M';

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  backgroundColor: AppTheme.background,
                  leading: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                    onPressed: () => _handleBack(context),
                  ),
                actions: [
                  ShareProductButton(productId: currentProduct.id.toString()),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border, size: 18),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'product-${currentProduct.id}',
                    child: Image.network(
                      currentProduct.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey.shade100,
                          child: const Center(
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://picsum.photos/seed/${currentProduct.id > 0 ? currentProduct.id : 1}/600/600',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 48,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  transform: Matrix4.translationValues(0.0, -32.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                currentProduct.name,
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(fontSize: 28, height: 1.2),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '\$${currentProduct.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    color: AppTheme.primary,
                                    fontSize: 24,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentProduct.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(height: 1.6, fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Select Color',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        ColorSelector(
                          colors: currentProduct.colors,
                          selectedColor: _selectedColor!,
                          onColorSelected: (color) {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Select Size',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SizeSelector(
                          sizes: currentProduct.sizes,
                          selectedSize: _selectedSize!,
                          onSizeSelected: (size) {
                            setState(() {
                              _selectedSize = size;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        PrimaryButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${currentProduct.name} added to cart',
                                ),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppTheme.primary,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
}
