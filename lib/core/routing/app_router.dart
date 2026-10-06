// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/login/cubit/log_in_cubit.dart';
import '../../features/auth/login/ui/login.dart';
import '../../features/auth/register/logic/cubit/register_cubit.dart';
import '../../features/auth/register/ui/register.dart';
import '../../features/start/spalsh/splash.dart';
import '../../features/users/chat_details/ui/chat_details.dart';
import '../../features/users/chats/ui/chats.dart';
import '../../features/users/home/home.dart';
import '../di/dependancy_injection.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final argument = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return _fadeRoute(builder: (_) => const Splash());
      case Routes.home:
        return _fadeRoute(builder: (_) => const Home());
      case Routes.login:
        return _fadeRoute(
          builder: (_) => BlocProvider(
            create: (context) => LogInCubit(logInRepo: getIt()),
            child: const LogIn(),
          ),
        );
      case Routes.register:
        return _fadeRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(registerRepo: getIt()),
            child: const Register(),
          ),
        );
      case Routes.chats:
        return _fadeRoute(builder: (_) => const Chats());
      case Routes.chatDetails:
        final argument = settings.arguments as String;
        return _fadeRoute(builder: (_) => ChatDetails(title: argument));

      default:
        // أي راوت من غير `case` بيقع هنا وبيفتح السبلاش — بنطبع تحذير في
        // الديبج عشان الحالة دي ماتعديش بصمت وتبان كأنها باج في الشاشة.
        assert(() {
          debugPrint('AppRouter: مافيش راوت اسمه ${settings.name}');
          return true;
        }());
        return _fadeRoute(builder: (_) => const Splash());
    }
  }

  /// A smooth fade + slide-up page transition applied to every route,
  /// giving a more polished feel than the default platform push.
  PageRouteBuilder _fadeRoute({required WidgetBuilder builder}) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 450),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
