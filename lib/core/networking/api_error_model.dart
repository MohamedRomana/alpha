import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../generated/locale_keys.g.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final int? status;

  ApiErrorModel({this.message, this.status});

  /// الرسالة اللي تتعرض للمستخدم.
  ///
  /// أي نص تقني (اسم استثناء، أثر مكدس، رد HTML) مالوش أي معنى عند المستخدم،
  /// فبيتحوّل لرسالة عامة. `ApiErrorHandler` المفروض ينضّف الرسالة قبل ما
  /// توصل هنا — ودي آخر خط دفاع لو حاجة فلتت.
  String get displayMessage {
    final text = (message ?? '').trim();
    if (text.isEmpty || _looksTechnical(text)) {
      return LocaleKeys.something_went_wrong.tr();
    }
    return text;
  }

  static bool _looksTechnical(String text) {
    const markers = [
      'Exception',
      'exception',
      '#0 ',
      '<!DOCTYPE',
      '<html',
      'stack trace',
      "type '",
      'Null check',
      'Instance of',
    ];
    return markers.any(text.contains);
  }

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}
