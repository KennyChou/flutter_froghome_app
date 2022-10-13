import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/theme/custum_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
      // theme: FlexThemeData.light(
      //   scheme: FlexScheme.dellGenoa,
      //   surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      //   blendLevel: 20,
      //   appBarStyle: FlexAppBarStyle.primary,
      //   appBarOpacity: 0.95,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 20,
      //     blendOnColors: false,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // ),
      // darkTheme: FlexThemeData.dark(
      //   colors: FlexColor.schemes[FlexScheme.dellGenoa]!.light.defaultError
      //       .toDark(10, true),
      //   surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      //   blendLevel: 15,
      //   appBarStyle: FlexAppBarStyle.primary,
      //   appBarOpacity: 0.90,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 30,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   // To use the playground font, add GoogleFonts package and uncomment
      //   // fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      // theme: FlexThemeData.light(
      //   scheme: FlexScheme.green,
      //   surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      //   blendLevel: 20,
      //   appBarOpacity: 0.95,
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   // To use the playground font, add GoogleFonts package and uncomment
      //   // fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      // darkTheme: FlexThemeData.dark(
      //   scheme: FlexScheme.green,
      //   surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      //   blendLevel: 15,
      //   appBarOpacity: 0.90,
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   // To use the playground font, add GoogleFonts package and uncomment
      //   // fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      // themeMode: ThemeMode.light,
    ),
  );
}
