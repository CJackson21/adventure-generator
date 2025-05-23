import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String? description;
  final IconData icon;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 30, color: const Color(0xFF931FAE)),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      subtitle: description != null ? Text(description!) : null,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
    );
  }
}
