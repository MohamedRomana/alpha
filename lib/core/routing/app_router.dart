// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import '../../features/start/spalsh/splash.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final argument = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return _fadeRoute(builder: (_) => const Splash());
    

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
