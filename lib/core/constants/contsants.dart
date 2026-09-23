import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String? token;
String? userId;
const String baseUrl = "https://abdo8.efadh.net/mafhos/api/";

/// رابط شات الدعم (Tawk.to) اللي بيتفتح في شاشة الدعم الفني.
///
/// ⚠️ ده لسه رابط مشروع تاني — لازم يتبدّل برابط حساب مفحوص من
/// لوحة تحكم Tawk (Direct Chat Link).
const String tawkDirectChatLink =
    'https://tawk.to/chat/61ac84c880b2296cfdd01712/1fm4udcia';
void openGoogleMap(double lat, double lng) async {
  Uri googleMapUrl = Uri.parse(
    "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
  );

  if (!await launchUrl(googleMapUrl)) {
    throw Exception('Could not launch $googleMapUrl');
  } else {
    throw 'Could not open the map.';
  }
}

Future<void> openCall(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(launchUri);
}

/// بيفتح رابط خارجي في المتصفح — مستخدم مع `external_url` بتاع الخدمات
/// اللي بتتحوّل لموقع الفحص الدوري.
Future<void> openExternalUrl(String url) async {
  if (url.isEmpty) return;
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

Future<void> openWhatsApp(String phoneNumber) async {
  final Uri launchUri = Uri.parse("https://wa.me/$phoneNumber");
  await launchUrl(launchUri);
}

bool isIPad(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final shortestSide = size.shortestSide;
  return shortestSide >= 600;
}
