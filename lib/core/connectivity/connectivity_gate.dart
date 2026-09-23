import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../widgets/flash_message.dart';
import '../../generated/locale_keys.g.dart';
import 'connectivity_service.dart';
import 'internet_lost_view.dart';

/// بيلفّ التطبيق كله: بيراقب النت، ولو قطع بيعرض [InternetLostView] فوق الشاشة
/// (بدل ما الصفحات تبقى بيضة)، وأول ما النت يرجع بيخفيها والتطبيق يكمّل شغّال.
/// لو النت ضعيف بيطلّع فلاش ماسدج مرة واحدة.
class ConnectivityGate extends StatefulWidget {
  final Widget child;
  const ConnectivityGate({super.key, required this.child});

  @override
  State<ConnectivityGate> createState() => _ConnectivityGateState();
}

class _ConnectivityGateState extends State<ConnectivityGate> {
  StreamSubscription<InternetConnectionStatus>? _sub;
  bool _offline = false;
  bool _retrying = false;
  // عشان منطلّعش فلاش "النت ضعيف" كل ثانية — بس لما الحالة تتغيّر لـ slow.
  bool _warnedSlow = false;

  @override
  void initState() {
    super.initState();
    _sub = ConnectivityService.instance.onStatusChange.listen(_onStatus);
  }

  Timer? _offlineTimer;

  void _onStatus(InternetConnectionStatus status) {
    if (!mounted) return;

    switch (status) {
      case InternetConnectionStatus.disconnected:
        _warnedSlow = false;

        // لا تعرض شاشة عدم الاتصال مباشرة، انتظر ثانيتين
        _offlineTimer?.cancel();
        _offlineTimer = Timer(const Duration(seconds: 2), () async {
          if (!mounted) return;

          final hasConnection =
              await ConnectivityService.instance.hasConnection;

          if (!mounted) return;

          if (!hasConnection && !_offline) {
            setState(() => _offline = true);
          }
        });
        break;

      case InternetConnectionStatus.slow:
        _offlineTimer?.cancel();

        if (_offline) {
          setState(() => _offline = false);
        }

        if (!_warnedSlow) {
          _warnedSlow = true;
          _showWeakFlash();
        }
        break;

      case InternetConnectionStatus.connected:
        _offlineTimer?.cancel();
        _warnedSlow = false;

        if (_offline) {
          setState(() => _offline = false);
        }
        break;
    }
  }

  void _showWeakFlash() {
    if (!mounted) return;
    showFlashMessage(
      context: context,
      type: FlashMessageType.warning,
      message: LocaleKeys.weak_internet.tr(),
    );
  }

  Future<void> _retry() async {
    setState(() => _retrying = true);
    final has = await ConnectivityService.instance.hasConnection;
    if (!mounted) return;
    setState(() {
      _retrying = false;
      if (has) _offline = false;
    });
  }

  @override
  void dispose() {
    _offlineTimer?.cancel();
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_offline)
          Positioned.fill(
            child: InternetLostView(onRetry: _retry, retrying: _retrying),
          ),
      ],
    );
  }
}
