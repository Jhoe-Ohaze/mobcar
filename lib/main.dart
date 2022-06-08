import 'package:flutter/material.dart';
import 'package:mobcar/assets/custom_colors.dart';
import 'package:mobcar/pages/login_page.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOBCAR',
      theme: ThemeData(
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
      home: const LoginPage(),
    );
  }
}
