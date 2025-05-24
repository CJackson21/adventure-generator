import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String leadImageUrl; 
  final List<String> poiIconTypes;
  final bool isSelected;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.leadImageUrl,
    required this.poiIconTypes,
    required this.isSelected,
    required this.onTap,
  });

  // Helper to map string types to IconData
  IconData _getPoiIcon(String iconType) {
    switch (iconType.toLowerCase()) {
      case 'sci_fi':
        return Icons.public; // Planet icon
      case 'space':
        return Icons.rocket_launch_outlined;
      case 'fantasy':
        return Icons.fort_sharp; // Castle icon
      case 'nordic':
        return Icons.shield_outlined; // Shield icon
      case 'weapon':
        return Icons.colorize_outlined; // Abstract for weapon/tech
      case 'journey':
        return Icons.explore_outlined;
      case 'realm':
        return Icons.layers_outlined;
      case 'exploration':
        return Icons.search_outlined;

      // POI Type Icons
      case 'food':
        return Icons.restaurant_outlined;
      case 'hike':
        return Icons.directions_walk_outlined;
      case 'store':
        return Icons.store_outlined;
      case 'park':
        return Icons.park_outlined;
      case 'cafe':
        return Icons.local_cafe_outlined;
      case 'bookstore':
        return Icons.menu_book_outlined;
      case 'landmark':
        return Icons.flag_outlined;
      default:
        return Icons.place_outlined; // Default fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary; 
    final Color selectionColor = const Color(0xFF931FAE); 

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: isSelected ? 4 : 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Softer corners
        side: isSelected
            ? BorderSide(color: selectionColor, width: 2) // Border when selected
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12), // Match card shape for ripple
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lead Image Section
            if (leadImageUrl.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9, // Common aspect ratio for images
                child: Image.network(
                  leadImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(selectionColor),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image_outlined,
                          color: Colors.grey[600], size: 50),
                    );
                  },
                ),
              ),
            if (leadImageUrl.isEmpty) // Fallback if no image URL
              Container(
                height: 150,
                color: Colors.grey[200],
                child: Icon(Icons.image_not_supported_outlined,
                    color: Colors.grey[600], size: 50),
              ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Selection Icon (Radio Button Style)
                      GestureDetector( 
                        onTap: onTap,
                        child: Icon(
                          isSelected
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_outlined,
                          color: isSelected ? selectionColor : Colors.grey[600],
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (description.isNotEmpty)
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 12),
                  // POI Type Icons Row
                  if (poiIconTypes.isNotEmpty)
                    Wrap( 
                      spacing: 8.0, 
                      runSpacing: 4.0,
                      children: poiIconTypes.map((type) {
                        return Chip(
                          avatar: Icon(
                            _getPoiIcon(type),
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          label: Text(
                            type.replaceAll('_', ' ').replaceFirstMapped( 
                                RegExp(r'\b[a-z]'), (match) => match.group(0)!.toUpperCase()),
                            style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                          ),
                          backgroundColor: Colors.grey[200],
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}