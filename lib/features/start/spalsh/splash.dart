// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/app_animations.dart';
import '../../../gen/assets.gen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedLogo(
          logo: Image.asset(Assets.img.logo.path, width: 350.w, height: 350.w),
          style: LogoAnimationStyle.auth,
        ),
      ),
    );
  }
}
