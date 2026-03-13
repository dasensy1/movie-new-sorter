import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../views/auth_screen.dart';
import '../views/home_screen.dart';
import '../views/film_detail_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final auth = context.read<AuthViewModel>();
    final isLoggedIn = auth.isLoggedIn;
    final isLoggingIn = state.matchedLocation == '/auth';

    if (!isLoggedIn && !isLoggingIn) {
      return '/auth';
    }

    if (isLoggedIn && isLoggingIn) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'film/:id',
          builder: (context, state) {
            final filmId = int.parse(state.pathParameters['id']!);
            return FilmDetailScreen(filmId: filmId);
          },
        ),
      ],
    ),
  ],
);
