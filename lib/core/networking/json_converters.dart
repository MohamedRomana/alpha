/// محوّلات متسامحة للحقول اللي السيرفر بيرجّعها بأكتر من نوع.
///
/// الباك اند بيرجّع نفس الحقل مرة `1` ومرة `true` ومرة `"1"` حسب الخدمة
/// (`has_guarantee` مثلاً)، والكاست المباشر بيرمي استثناء ويكسر الشاشة
/// كلها. المحوّلات دي بتقبل الأشكال دي كلها.
library;

/// أي شكل منطقي: `true` · `1` · `"1"` · `"true"`.
bool? boolFromJson(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  final text = value.toString().trim().toLowerCase();
  if (text.isEmpty) return null;
  return text == '1' || text == 'true' || text == 'yes';
}

/// أي شكل رقمي: `5` · `"5"` · `5.0` · `true`.
int? intFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is bool) return value ? 1 : 0;
  return int.tryParse(value.toString().trim());
}

String? stringFromJson(dynamic value) => value?.toString();
