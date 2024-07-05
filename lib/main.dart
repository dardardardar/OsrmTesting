import 'package:flutter/material.dart';
import 'package:osrmtesting/features/home/presentation/pages/home_page.dart';
import 'package:osrmtesting/get_it_container.dart';

Future<void> main() async {
  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
