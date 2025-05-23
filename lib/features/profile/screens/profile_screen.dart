import 'package:flutter/material.dart';
import 'package:adventure_app/core/layout/layout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(currentIndex: 3, child: Center(child: Text('Profile')));
  }
}
