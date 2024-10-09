import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/home_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
const apiKey = 'AIzaSyCbtkkiR3iwR2cP3N6uN8yjooRO8Bj_9r8';
void main() {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gemini',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

