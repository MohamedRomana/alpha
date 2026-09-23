import 'package:internet_connection_checker/internet_connection_checker.dart';

/// خدمة مراقبة الإنترنت الحقيقي (مش بس الواي فاي/الداتا) — بتـ ping فعليًا.
/// بترجّع حالة: connected / disconnected / slow (نت ضعيف).
class ConnectivityService {
  ConnectivityService._();
  static final ConnectivityService instance = ConnectivityService._();

  final InternetConnectionChecker _checker =
      InternetConnectionChecker.createInstance(
        // بنعيد الفحص كل 5 ثواني عشان نلقط رجوع النت والتطبيق مفتوح.
        checkInterval: const Duration(seconds: 5),
        // مهم: الديفولت بيفحص سيرفرات تالتة (dummyapi/fakestoreapi...) بطيئة
        // أو محجوبة على بعض الشبكات فبتطلّع "مفيش نت" أو "ضعيف" بالغلط.
        // بنفحص سيرفر التطبيق نفسه + جوجل — أي رد HTTP معناه فيه نت،
        // ولو أي واحد منهم ردّ يبقى متصل (requireAll = false افتراضيًا).
        addresses: [
          AddressCheckOption(
            uri: Uri.parse('https://abdo8.efadh.net/mafhos/api'),
          ),
          AddressCheckOption(uri: Uri.parse('https://www.google.com')),
        ],
        // كشف النت الضعيف بحد عالي (5 ثواني) عشان منطلّعش تحذير غلط.
        slowConnectionConfig: const SlowConnectionConfig(
          enableToCheckForSlowConnection: true,
          slowConnectionThreshold: Duration(seconds: 5),
        ),
      );

  /// ستريم بيبعت الحالة كل ما تتغيّر.
  Stream<InternetConnectionStatus> get onStatusChange =>
      _checker.onStatusChange;

  /// فحص لحظي هل فيه نت.
  Future<bool> get hasConnection => _checker.hasConnection;
}
