import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.img.logo.path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
