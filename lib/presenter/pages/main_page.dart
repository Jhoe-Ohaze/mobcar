import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../assets/custom_colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MOBCAR',
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: CustomColors.primaryBlack,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.blue),
          iconTheme: IconThemeData(color: Colors.blue),
          toolbarTextStyle: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
