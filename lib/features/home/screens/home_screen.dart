import 'package:flutter/material.dart';
import 'package:adventure_app/core/layout/layout.dart';
import 'package:adventure_app/shared/widgets/feature_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  // Adventure data can be a static member or managed differently if fetched dynamically
  // TODO: this will all be fetched from backend later. Just a placeholder rn
  static final List<Map<String, dynamic>> adventures = [
    {
      'title': 'Death Star Tour',
      'description': 'A guided tour through the galaxy\'s most iconic weapon.',
      'leadImageUrl': 'https://placehold.co/600x338/2c3e50/ffffff/png?text=Death+Star+Concept',
      'poiIconTypes': ['sci_fi', 'space', 'weapon', 'exploration'],
    },
    {
      'title': 'Mordor Expedition',
      'description': 'Journey through the land of shadow and fire, if you dare.',
      'leadImageUrl': 'https://placehold.co/600x338/d35400/ffffff/png?text=Mordor+Landscape',
      'poiIconTypes': ['fantasy', 'journey', 'realm', 'hike'],
    },
    {
      'title': 'The Spiral Realm Ascent',
      'description': 'Pierce the heavens with your drill! Rise from the depths, your destiny awaits!',
      'leadImageUrl': 'https://placehold.co/600x338/2980b9/ffffff/png?text=Kamina+Or+Something',
      'poiIconTypes': ['realm', 'journey', 'sci_fi', 'fantasy'],
    },
    {
      'title': 'Whiterun Marketplace Jaunt',
      'description': 'Explore a Nordic stronghold, trade goods, and maybe take an arrow to the knee.',
      'leadImageUrl': 'https://placehold.co/600x338/7f8c8d/ffffff/png?text=Whiterun+Market',
      'poiIconTypes': ['fantasy', 'nordic', 'store', 'exploration'],
    },
    {
      'title': 'Newberg Park & Cafe Stroll',
      'description': 'A relaxing walk in a local Newberg park followed by delightful coffee and pastries.',
      'leadImageUrl': 'https://placehold.co/600x338/27ae60/ffffff/png?text=Park+%26+Cafe',
      'poiIconTypes': ['park', 'cafe', 'food', 'store'],
    },
    {
      'title': 'No Image Adventure',
      'description': 'This adventure has no lead image, testing fallback.',
      'leadImageUrl': '',
      'poiIconTypes': ['exploration', 'food'],
    }
  ];

  @override
  Widget build(BuildContext context) {
    final selectedAdventureTitle = useState<String?>(null);

    final Color primaryButtonColor = const Color(0xFF931FAE);
    final Color onPrimaryButtonColor = Colors.white;
    final bool isAdventureSelected = selectedAdventureTitle.value != null;
    const double buttonAreaHeight = 90.0;

    final Color buttonBackgroundColor = isAdventureSelected ? primaryButtonColor : Colors.grey[400]!;

    final buttonOnPressed = useCallback(() {
      if (!isAdventureSelected) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Starting: ${selectedAdventureTitle.value}'),
          backgroundColor: primaryButtonColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
    }, [
      selectedAdventureTitle.value,
      isAdventureSelected,
    ]);

    return Layout(
      currentIndex: 0,
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      top: 80, bottom: 20, left: 20, right: 20),
                  child: Text(
                    'Adventure Awaits',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final adventure = adventures[index];
                    final title = adventure['title']! as String;
                    final isItemSelected = title == selectedAdventureTitle.value;

                    return FeatureCard(
                      title: title,
                      description: adventure['description']! as String,
                      leadImageUrl: adventure['leadImageUrl']! as String,
                      poiIconTypes: adventure['poiIconTypes']! as List<String>,
                      isSelected: isItemSelected,
                      onTap: () {
                        selectedAdventureTitle.value = isItemSelected ? null : title;
                      },
                    );
                  },
                  childCount: adventures.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: buttonAreaHeight),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                  stops: const [0.0, 0.3, 0.8],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 15.0, top: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBackgroundColor,
                    foregroundColor: onPrimaryButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: buttonOnPressed,
                  child: const Text(
                    'Begin Adventure',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}