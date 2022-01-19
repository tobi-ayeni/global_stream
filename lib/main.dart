import 'package:flutter/material.dart';
import 'package:global_stream/ui/onboarding/signin.dart';
import 'package:global_stream/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assessment',
      theme: kThemeData,
      home: const SignIn(),
    );
  }
}
