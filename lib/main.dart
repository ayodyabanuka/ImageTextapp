import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rp/Providers/AddnewTestProvider.dart';
import 'package:rp/Providers/AnswerProvider.dart';
import 'package:rp/Providers/TestProvider.dart';
import 'package:rp/TestScreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AnswerProvider()),
    ChangeNotifierProvider(create: (_) => TestProvider()),
    ChangeNotifierProvider(create: (_) => AddnewTestProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TestScreen());
  }
}
