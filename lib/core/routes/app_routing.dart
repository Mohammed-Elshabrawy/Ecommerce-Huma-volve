import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/view/login/login_screen.dart';
import '../../features/auth/presentation/view/sign_up/sign_up_screen.dart';
import '../../features/details/presentation/view/product_details_screen.dart';
import '../../features/main_navigation/screens/main_navigation_screen.dart';
import '../../features/splash/screens/splash_screen.dart';

final appRouting = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return const MainNavigationScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final productIdStr = state.pathParameters['id'] ?? '0';
        final parsedId = int.tryParse(productIdStr) ?? 0;
        return ProductDetailsScreen(productId: parsedId);
      },
    ),
  ],
);
