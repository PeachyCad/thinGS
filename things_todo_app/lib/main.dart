import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';

void main() {
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
