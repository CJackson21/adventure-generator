import 'package:flutter/material.dart';
import 'package:adventure_app/core/services/supabase_initializer.dart';
import 'package:adventure_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  runApp(const MyApp());
}
