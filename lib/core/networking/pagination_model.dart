import 'package:json_annotation/json_annotation.dart';
part 'pagination_model.g.dart';

/// مفتاح `pagination` اللي بيجي جنب `data` في الخدمات اللي بترجّع قوائم طويلة
/// (طلباتي، طلبات المندوب، الرسائل، الإشعارات، المحفظة).
///
/// التحكم من الريكوست بالبارامترين `limit` و `page`.
@JsonSerializable()
class PaginationModel {
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'last_page')
  final int? lastPage;
  @JsonKey(name: 'per_page')
  final int? perPage;
  final int? total;

  PaginationModel({this.currentPage, this.lastPage, this.perPage, this.total});

  /// هل فيه صفحة بعد الحالية — للـ infinite scroll.
  bool get hasMore => (currentPage ?? 1) < (lastPage ?? 1);

  /// رقم الصفحة اللي بعدها.
  int get nextPage => (currentPage ?? 1) + 1;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
