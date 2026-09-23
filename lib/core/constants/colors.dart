import 'package:flutter/material.dart';

/// بيحوّل قيمة الـ hex الجاية من السيرفر لـ [Color].
///
/// السيرفر بقى بيرجّع `status_hex` (وكمان `color` في الإشعارات و `hex` في
/// ألوان المركبات) بقيمة جاهزة زي `#1A5FA8` بدل اسم كلاس بوتستراب القديم
/// `status_color` — فمافيش أي جدول تحويل في التطبيق.
///
/// أي قيمة فاضية أو غير صالحة بترجع الرمادي الافتراضي `#7A8798` زي ما
/// السيرفر بيعمل، فمافيش حاجة اسمها حالة `else`.
Color hexToColor(String? hex) {
  const fallback = Color(0xFF7A8798);
  if (hex == null || hex.isEmpty) return fallback;

  var value = hex.replaceAll('#', '').trim();
  if (value.length == 6) value = 'FF$value';
  if (value.length != 8) return fallback;

  final parsed = int.tryParse(value, radix: 16);
  return parsed == null ? fallback : Color(parsed);
}

abstract class AppColors {
  static const Color primary = Color(0xff004279);

  /// لون الشعار — العلامة التجارية مسجّلة أسود مش أزرق، فالماركة بتتلوّن
  /// باللون ده في كل مكان بتظهر فيه.
  static const Color logoColor = Color(0xff000000);
  static const Color secondray = Color(0xff306099);
  static const Color startButtonColor = Color(0xff0D8D90);
  static const Color textColor = Color(0xff424750);
  static const Color smallTextColor = Color(0xff727781);
  static const Color boldTextColor = Color(0xff0B1C30);
  static const Color backColor = Color(0xffF8F9FF);
  static const Color darkRed = Color(0xffBE1622);
  static const Color borderColor = Color(0xffC2C6D2);
  static const Color thirdColor = Color(0xff1F2A37);
  static const Color fourthColor = Color(0xffEDF0EF);
  static const Color accent = Color(0xffF4A261);
  static const Color lightBlue = Color(0xffDCE9FF);
  static const Color avatarBackColor = Color(0xffD3E3FF);
  static const Color onPrimaryTextColor = Color(0xffB3D1FF);
  static const Color packageColor = Color(0xff155A9C);
  static const Color surfaceColor = Color(0xffF8F9FF);
  static const Color skyBlue = Color(0xff91BEFD);
  static const Color peachLight = Color(0xffFFDCC4);
  static const Color peach = Color(0xffFFC499);
  static const Color brownDark = Color(0xff683400);
  static const Color dividerColor = Color(0xffE5EEFF);
  static const Color logoutBackColor = Color(0xffFFDAD6);
  static const Color dangerColor = Color(0xffBA1A1A);
  static const Color logoutTextColor = Color(0xff93000A);
  static const Color paleBlue = Color(0xffEFF4FF);
  static const Color greenLight = Color(0xffDCFCE7);
  static const Color authBackColor = Color(0xffF3F3F3);
  static const Color onlineColor = Color(0xff10B981);
  static const Color statCardColor = Color(0xffDEE8FF);
  static const Color historyFooterColor = Color(0xffF0F3FF);
}
