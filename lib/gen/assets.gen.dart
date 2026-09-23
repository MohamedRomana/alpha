// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/Lang/ar.json
  String get ar => 'assets/Lang/ar.json';

  /// File path: assets/Lang/en.json
  String get en => 'assets/Lang/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Tajawal-Bold.ttf
  String get tajawalBold => 'assets/fonts/Tajawal-Bold.ttf';

  /// File path: assets/fonts/Tajawal-Medium.ttf
  String get tajawalMedium => 'assets/fonts/Tajawal-Medium.ttf';

  /// File path: assets/fonts/Tajawal-Regular.ttf
  String get tajawalRegular => 'assets/fonts/Tajawal-Regular.ttf';

  /// List of all assets
  List<String> get values => [tajawalBold, tajawalMedium, tajawalRegular];
}

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/emptyorder.json
  String get emptyorder => 'assets/img/emptyorder.json';

  /// File path: assets/img/error.json
  String get error => 'assets/img/error.json';

  /// File path: assets/img/internet_lost.json
  String get internetLost => 'assets/img/internet_lost.json';

  /// File path: assets/img/loading.json
  String get loading => 'assets/img/loading.json';

  /// File path: assets/img/location.json
  String get location => 'assets/img/location.json';

  /// File path: assets/img/login.json
  String get login => 'assets/img/login.json';

  /// File path: assets/img/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/img/logo.png');

  /// List of all assets
  List<dynamic> get values => [
    emptyorder,
    error,
    internetLost,
    loading,
    location,
    login,
    logo,
  ];
}

abstract final class Assets {
  static const $AssetsLangGen lang = $AssetsLangGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImgGen img = $AssetsImgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
