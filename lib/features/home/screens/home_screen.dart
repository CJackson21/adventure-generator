import 'package:flutter/material.dart';
import 'package:adventure_app/core/layout/layout.dart'; // Assuming this is your custom Layout widget
import 'package:adventure_app/shared/widgets/feature_card.dart'; // Your updated FeatureCard widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedAdventure;

  // TODO: Change when this is a populated list from the backend
  final List<Map<String, String>> adventures = [
    {
      'title': 'Death Star Tour',
      'description': 'A guided tour through the galaxy\'s most iconic weapon.',
    },
    {
      'title': 'Mordor',
      'description': 'Journey through the land of shadow and fire.',
    },
    {
      'title': 'The Spiral Realm',
      'description': 'Unravel mysteries in a dimension of twisted time.',
    },
    {
      'title': 'Whiterun',
      'description': 'Explore a Nordic stronghold in the heart of Skyrim.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Layout(
      currentIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 100, bottom: 5),
              child: const Text(
                'Adventure Awaits',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // This padding applies to the content of the list.
              // Dividers will also be constrained by this horizontal padding.
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: adventures.length,
              itemBuilder: (context, index) {
                final adventure = adventures[index];
                final title = adventure['title']!;
                final description = adventure['description']!;
                final isSelected = title == selectedAdventure;

                return FeatureCard(
                  title: title,
                  description: description,
                  icon:
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                  onTap: () {
                    setState(() {
                      selectedAdventure = isSelected ? null : title;
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey.withOpacity(0.3),
                );
              },
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF931FAE),
                      foregroundColor: const Color(0xFFFFFFFF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed:
                        selectedAdventure == null
                            ? null
                            : () {
                              if (selectedAdventure != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Starting: $selectedAdventure',
                                    ),
                                  ),
                                );
                              }
                            },
                    child: const Text('Begin Adventure'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
