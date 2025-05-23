import 'package:flutter/material.dart';
// import 'package:adventure_app/features/auth/screens/login_screen.dart';
import 'package:adventure_app/features/home/screens/home_screen.dart';
import 'package:adventure_app/features/map/screens/map_screen.dart';
import 'package:adventure_app/features/profile/screens/profile_screen.dart';
import 'package:adventure_app/features/adventures/screens/adventures_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventure App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(),
        '/adventures': (context) => const AdventuresScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
