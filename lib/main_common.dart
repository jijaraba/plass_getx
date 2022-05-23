import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:injectable/injectable.dart';
import 'package:plass_getx/lib/src/config/localizations.dart';
import 'package:plass_getx/lib/src/core/presentation/theme/theme.dart';
import 'package:plass_getx/lib/src/core/utils/commons_extensions.dart';
import 'package:plass_getx/lib/src/core/utils/logger.dart';
import 'package:plass_getx/lib/src/presentation/routes/pages.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';
import 'package:plass_getx/lib/src/presentation/splash/splash_binding.dart';

Future<void> mainCommon(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runZonedGuarded(
    () async {
      await SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp],
      );
      HttpOverrides.global = TempHttpOverrides();
      await _configureSystemUI();
      FlutterError.onError = _handleFlutterError;
      runApp(
        App(),
      );
    },
    _handleError,
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      locale: Locale('es'),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizationsDelegate('Plass'),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('es'),
      ],
      onGenerateTitle: (ctx) => ctx.localizations.text('common.app_name'),
      theme: materialTheme,
      initialRoute: AppRoutes.splash,
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
    );
  }
}

Future<void> _configureSystemUI() {
  return SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

void _handleFlutterError(FlutterErrorDetails details) {
  FlutterError.dumpErrorToConsole(details);
}

void _handleError(Object error, StackTrace stack) {
  logger.e('App Zone Error', error, stack);
}

class TempHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}
