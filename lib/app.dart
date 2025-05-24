import 'package:flutter/material.dart';

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
      onGenerateRoute: (RouteSettings settings) {
        Widget pageWidget;

        switch (settings.name) {
          case '/home':
            pageWidget = const HomeScreen();
            break;
          case '/map':
            pageWidget = const MapScreen();
            break;
          case '/adventures':
            pageWidget = const AdventuresScreen();
            break;
          case '/profile':
            pageWidget = const ProfileScreen();
            break;
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('Error: No route defined for ${settings.name}'),
                ),
              ),
            );
        }

        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      },
    );
  }
}
