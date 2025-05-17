import 'package:flutter/material.dart';

class AdventureDisplay extends StatelessWidget {
  final Map<String, dynamic>? activity;
  final VoidCallback onRefresh;

  const AdventureDisplay({
    super.key,
    required this.activity,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (activity == null) {
      return Column(
        children: [
          const Text('No adventure loaded yet.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRefresh,
            child: const Text('Find Me an Adventure'),
          ),
        ],
      );
    }

    return Column(
      children: [
        Text(
          activity!['title'] ?? 'No title',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (activity!['category'] != null)
          Text(
            'Category: ${activity!['category']}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onRefresh,
          child: const Text('Find Another Adventure'),
        ),
      ],
    );
  }
}
