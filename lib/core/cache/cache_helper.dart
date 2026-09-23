import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper {
  static late SharedPreferences _preferences;

  /// إشعار يتغيّر مع العنوان عشان الواجهات تتحدّث فوراً بعد تحديث الموقع.
  static final ValueNotifier<String> addressNotifier = ValueNotifier<String>(
    '',
  );
  static const _userId = 'id';
  static const _token = 'token';
  static const _isGuest = 'isGuest';
  static const _language = 'lang';
  static const _showImage = 'showImage';
  static const _deviceToken = 'deviceToken';
  static const _type = 'type';
  static const _intro = 'intro';
  static const _address = 'address';
  static const _lat = 'lat';
  static const _lng = 'lng';

  /// نسخة في الذاكرة من مفاتيح الجلسة.
  ///
  /// الكتابة في `SharedPreferences` غير متزامنة والقراءة متزامنة، فلو حد
  /// حفظ الجلسة من غير `await` (زي ما بيحصل جوه callbacks الـ cubits) كان
  /// ممكن ريكوست يطلع قبل ما التوكن يتكتب فيروح من غير `Authorization`.
  /// النسخة دي بتتحدّث فوراً، فالقراءة صح من أول لحظة.
  static String? _tokenCache;
  static String? _userIdCache;
  static String? _userTypeCache;
  static bool? _isGuestCache;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String getAddress() {
    return _preferences.getString(_address) ?? '';
  }

  static Future<void> setAddress(String? address) async {
    await _preferences.setString(_address, address ?? '');
    addressNotifier.value = address ?? '';
  }

  static Future<void> setLat(String? lat) async {
    await _preferences.setString(_lat, lat ?? '');
  }

  static String getLat() {
    return _preferences.getString(_lat) ?? '';
  }

  static Future<void> setLng(String? lng) async {
    await _preferences.setString(_lng, lng ?? '');
  }

  static String getLng() {
    return _preferences.getString(_lng) ?? '';
  }

  static Future<void> setUserId(String? id) async {
    _userIdCache = id ?? '';
    await _preferences.setString(_userId, id ?? '');
  }

  static String getUserId() {
    return _userIdCache ?? _preferences.getString(_userId) ?? '';
  }

  static Future<void> setToken(String? token) async {
    _tokenCache = token ?? '';
    await _preferences.setString(_token, token ?? '');
  }

  static String getToken() {
    return _tokenCache ?? _preferences.getString(_token) ?? '';
  }

  static Future<void> setIsGuest(bool isGuest) async {
    _isGuestCache = isGuest;
    await _preferences.setBool(_isGuest, isGuest);
  }

  /// حساب الزائر مسموح له يتصفّح بس — ممنوع يضيف مركبة أو ينشئ طلب
  /// (السيرفر بيرجّع 403 برسالة «برجاء إنشاء حساب لإتمام هذه العملية»).
  static bool getIsGuest() {
    return _isGuestCache ?? _preferences.getBool(_isGuest) ?? false;
  }

  /// بيحفظ جلسة المستخدم بعد أي نقطة دخول
  /// (`register` · `check-code` · `guest-login` · `reset-password`).
  ///
  /// الأربع قيم بتتكتب مع بعض مش واحدة ورا التانية: لو استنينا كل واحدة
  /// لوحدها، التوكن بيتكتب بعد ورتين await — والشاشة اللي بعد الدخول بتبعت
  /// أول ريكوست في نفس اللحظة فبيطلع من غير توكن، والسيرفر بيرد 401
  /// والمستخدم بيتطرد لشاشة الدخول بعد ما دخل بثانية.


  /// بيمسح الجلسة عند تسجيل الخروج أو حذف الحساب أو رجوع 401.
  static Future<void> clearUserSession() async {
    await Future.wait([
      setUserId(''),
      setUserType(''),
      setToken(''),
      setIsGuest(false),
    ]);
  }

  static Future<void> setShowIntro(bool? showIntro) async {
    await _preferences.setBool(_intro, showIntro ?? false);
  }

  static bool getShowIntro() {
    return _preferences.getBool(_intro) ?? false;
  }

  static Future<void> setShowImage(bool? showImage) async {
    await _preferences.setBool(_showImage, showImage ?? false);
  }

  static bool getShowImage() {
    return _preferences.getBool(_showImage) ?? false;
  }

  static Future<void> setDeviceToken(String? deviceToken) async {
    await _preferences.setString(_deviceToken, deviceToken ?? '');
  }

  static String getDeviceToken() {
    return _preferences.getString(_deviceToken) ?? '';
  }

  static Future<void> setUserType(String? type) async {
    _userTypeCache = type ?? '';
    await _preferences.setString(_type, type ?? '');
  }

  static String getUserType() {
    return _userTypeCache ?? _preferences.getString(_type) ?? '';
  }

  static Future<void> removeUserId(String key) async {
    await _preferences.remove(_userId);
  }

  static Future<void> clearData() async {
    _tokenCache = null;
    _userIdCache = null;
    _userTypeCache = null;
    _isGuestCache = null;
    await _preferences.clear();
  }

  static Future<void> setLang(String lang) async {
    await _preferences.setString(_language, lang);
  }

  static String getLang() {
    return _preferences.getString(_language) ?? "";
  }
}
