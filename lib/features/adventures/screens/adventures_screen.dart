import 'package:flutter/material.dart';
import 'package:adventure_app/core/layout/layout.dart';

class AdventuresScreen extends StatelessWidget {
  const AdventuresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(currentIndex: 2, child: Center(child: Text('Adventures')));
  }
}
