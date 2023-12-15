import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_math/presentation/di.dart';
import 'package:quick_math/presentation/home/home_page.dart';
import 'package:quick_math/presentation/themes/app_color.dart';

import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Di.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routesMap,
        onGenerateRoute: onGenerateRoute,
        title: 'Quick Math',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.transparent
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.transparent, background: AppColor.mainColor),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
