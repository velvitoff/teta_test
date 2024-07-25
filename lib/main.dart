import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:teta_test/app.dart';
import 'package:teta_test/locator.dart';

Future<void> main() async {
  await Hive.initFlutter();
  setup();
  await locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}
