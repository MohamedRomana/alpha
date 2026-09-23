import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';
import 'api_error_model.dart';

/// بيحوّل أي استثناء لرسالة تنفع تتعرض للمستخدم.
///
/// من غيره الريبوز كانت بتعرض `error.toString()` فالمستخدم كان بيشوف
/// `DioException [bad response]: ...` بدل رسالة السيرفر.
class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          return _fromResponse(error.response?.data);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: LocaleKeys.something_went_wrong.tr());
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return ApiErrorModel(message: LocaleKeys.connection_error.tr());
        default:
          return ApiErrorModel(message: LocaleKeys.something_went_wrong.tr());
      }
    }
    if (error is ApiErrorModel) return error;

    // أي حاجة تانية (زي فشل تحويل الـ JSON) — الرسالة التقنية مالهاش لازمة
    // عند المستخدم.
    return ApiErrorModel(message: LocaleKeys.something_went_wrong.tr());
  }

  /// جسم الخطأ ممكن يرجع Map فيه `message`، وممكن يرجع صفحة HTML أو نص
  /// خام لو السيرفر وقع — الحالتين لازم يطلعوا رسالة مفهومة.
  static ApiErrorModel _fromResponse(dynamic data) {
    if (data is Map) {
      final message = data['message'];
      if (message is String && message.isNotEmpty) {
        return ApiErrorModel(message: message, status: data['code']);
      }

      // أخطاء الفاليديشن بترجع `errors: {field: [msg]}` — بنعرض أول رسالة.
      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) {
          return ApiErrorModel(message: '${first.first}');
        }
      }
    }
    return ApiErrorModel(message: LocaleKeys.something_went_wrong.tr());
  }
}
