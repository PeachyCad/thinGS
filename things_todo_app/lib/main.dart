import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: ProviderScope(
        child: HomePage(),
      ),
    ),
  );
}
