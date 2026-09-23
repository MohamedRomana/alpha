// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/cache/cache_helper.dart';
import 'core/connectivity/connectivity_gate.dart';
import 'core/constants/colors.dart';
import 'core/di/dependancy_injection.dart';
import 'core/networking/bloc_observer.dart';
import 'core/routing/app_router.dart';
import 'core/routing/navigator_key.dart';
import 'core/routing/routes.dart';
import 'gen/fonts.gen.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await setUpGetIt();
  // await NotificationHelper.initFirebaseAndFCM();
  await EasyLocalization.ensureInitialized();

  debugPrint("userId is ${CacheHelper.getUserId()}");

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      saveLocale: true,
      useOnlyLangCode: true,
      startLocale: Locale(
        CacheHelper.getLang() == "" ? "ar" : CacheHelper.getLang(),
      ),
      assetLoader: const CodegenLoader(),
      path: 'assets/Lang',
      fallbackLocale: Locale(
        CacheHelper.getLang() == "" ? "ar" : CacheHelper.getLang(),
      ),
      child: MyApp(appRouter: AppRouter()),
    ),
  );

  // NotificationHelper.setupListeners();
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: FontFamily.tajawalRegular,
              scaffoldBackgroundColor: AppColors.backColor,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColors.primary,
                selectionColor: AppColors.primary.withOpacity(0.5),
                selectionHandleColor: AppColors.primary,
              ),
            ),
            debugShowCheckedModeBanner: false,
            builder: (context, child) => ConnectivityGate(child: child!),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: navigatorKey,
            onGenerateRoute: widget.appRouter.onGenerateRoute,
            initialRoute: Routes.splash,
          ),
        );
      },
    );
  }
}
