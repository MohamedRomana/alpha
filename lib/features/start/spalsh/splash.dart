import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(Assets.img.logo.path)));
  }
}
