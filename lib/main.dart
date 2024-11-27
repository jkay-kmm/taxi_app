import 'package:flutter/material.dart';
import 'package:global_taxi_app/auth/login.dart';
import 'package:global_taxi_app/common/nav_bar_screen.dart';
import 'package:global_taxi_app/home/home_screen.dart';
import 'package:global_taxi_app/onbording/onbording_screen.dart';
import 'package:global_taxi_app/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(

      ),
    );
  }
}
