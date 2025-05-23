import 'package:flutter/material.dart';
import 'package:adventure_app/core/layout/layout.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(currentIndex: 1, child: Center(child: Text('Map')));
  }
}
