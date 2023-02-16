import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/home_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("todo_db");

  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData(
          fontFamily: 'RobotoMono',
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: const Color.fromARGB(255, 132, 159, 181),
        ),
      ),
    ),
  );
}
