import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'di/injection_container.dart';
import 'l10n/app_localizations.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/vehicle_provider.dart';
import 'presentation/providers/service_provider.dart';
import 'presentation/providers/localization_provider.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'core/themes/app_theme.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository: InjectionContainer.authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => VehicleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceProvider(),
        ),
      ],
      child: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
          return MaterialApp(
            title: 'Compumatrix',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: localizationProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
            ],
            routes: AppRoutes.routes,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
