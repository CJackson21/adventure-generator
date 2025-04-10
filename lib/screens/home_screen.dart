import 'package:flutter/material.dart';
import 'package:adventure_app/logic/adventure_loader.dart';
import 'package:adventure_app/widgets/adventure_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _activity;

  Future<void> _refreshAdventure() async {
    final result = await AdventureLoader.load();
    setState(() => _activity = result);
  }

  @override
  void initState() {
    super.initState();
    _refreshAdventure();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adventure App")),
      body: Center(
        child: AdventureDisplay(
          activity: _activity,
          onRefresh: _refreshAdventure,
        ),
      ),
    );
  }
}
