import 'package:flutter/material.dart';

/// مفتاح الناڤيجيتور العام — بيتستخدم من `MaterialApp` ومن الحاجات اللي
/// مش عندها `context` (زي إنترسبتور الـ Dio لما يمسك 401).
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
