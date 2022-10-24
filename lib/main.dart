import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/theme/custum_theme.dart';
import 'package:flutter_froghome_app/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(
    GetMaterialApp.router(
      title: "蛙記錄",
      getPages: AppPages.routes,
      onReady: () => Get.rootDelegate.offNamed(Routes.HOME),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'TW'),
      ],
      theme: myLightTheme,
      darkTheme: myDarkTheme,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    ),
  );
}
