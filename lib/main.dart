import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'infra/modules/main_module.dart';
import 'presenter/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final _openBox = await Hive.openBox<String>('cars');
  await _openBox.clear();

  runApp(
    ModularApp(
      module: MainModule(),
      child: const MainPage(),
    ),
  );
}
