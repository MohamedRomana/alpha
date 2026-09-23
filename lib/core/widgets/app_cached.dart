import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/assets.gen.dart';
import '../constants/colors.dart';
import 'app_animations.dart';

/// أي صورة جاية من السيرفر بتتعرض من هنا.
///
/// بتتعامل مع تلات حالات:
/// * **الرابط فاضي أو مش رابط صالح** → بنعرض الصورة الافتراضية على طول من غير
///   ما نضرب ريكوست أصلاً.
/// * **بتتحمّل** → شيمر بنفس مقاس الصورة.
/// * **فشلت** (رابط باظ / صورة محذوفة / مافيش نت) → نفس الصورة الافتراضية
///   بدل أيقونة خطأ.
class AppCachedImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  /// صورة بديلة من الأصول لو الرابط فاضي أو فشل — الافتراضي لوجو التطبيق.
  final String? defaultImage;

  /// راديوس اختياري عشان مانلفّش الودجت في `ClipRRect` في كل مكان.
  final double? radius;

  const AppCachedImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.defaultImage,
    this.radius,
  });

  /// السيرفر بيرجّع أحياناً `null` أو نص فاضي أو مسار مش كامل — أي حاجة
  /// مش `http` مابنحاولش نحمّلها.
  bool get _hasValidUrl {
    final url = image.trim();
    return url.isNotEmpty && url.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    final child = _hasValidUrl
        ? CachedNetworkImage(
            width: width ?? 100.w,
            height: height ?? 100.h,
            fit: fit ?? BoxFit.cover,
            imageUrl: image.trim(),
            // وقت التحميل: خلفية بيضا واللوجو باهت في النص — الخلفية
            // الزرقا كانت بتبان كشاشة لونها غريب جوه الكروت.
            placeholder: (context, url) => _loading(),
            errorWidget: (context, url, error) => _fallback(),
          )
        : _fallback();

    if (radius == null) return child;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: child,
    );
  }

  /// شكل التحميل — نفس شكل البديل بس اللوجو بينبض بخفة عشان يبان إنها
  /// بتحمّل، من غير أي لون غريب.
  Widget _loading() {
    return Container(
      height: height ?? 100.h,
      width: width ?? 100.w,
      alignment: Alignment.center,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Breathing(
          child: Image.asset(
            defaultImage ?? Assets.img.logo.path,
            // اللوجو بلون العلامة (أسود)، وأي صورة بديلة تانية بلونها الأصلي.
            color: defaultImage == null ? AppColors.logoColor : null,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _fallback() {
    return Container(
      height: height ?? 100.h,
      width: width ?? 100.w,
      alignment: Alignment.center,
      color: Colors.white,
      child: Padding(
        // اللوجو مايفضلش لازق في حواف الكارت.
        padding: EdgeInsets.all(8.r),
        child: Image.asset(
          defaultImage ?? Assets.img.logo.path,
          color: defaultImage == null ? AppColors.logoColor : null,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
