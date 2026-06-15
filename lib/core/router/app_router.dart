import 'package:go_router/go_router.dart';
import '../../features/auth/splash/splash_screen.dart';
import '../../features/auth/login/login_screen.dart';
import '../../features/auth/otp/otp_screen.dart';
import '../../features/auth/forgot_password/forgot_password_screen.dart';
import '../../features/auth/forgot_password/create_password_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/news/news_list_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // ── Auth ────────────────────────────────────────
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          return OtpScreen(phone: phone);
        },
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/new-password',
        name: 'new-password',
        builder: (context, state) => const CreatePasswordScreen(),
      ),

      // ── Main App ─────────────────────────────────────
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/news-list',
        name: 'news-list',
        builder: (context, state) => const NewsListScreen(),
      ),
    ],
  );
}
