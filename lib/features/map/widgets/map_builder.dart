// lib/features/map/widgets/map_builder.dart (or a similar path)
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

// Data class to hold all necessary data for building the map
class MapConfigData {
  final MapController mapController;
  final LatLng center;
  final double zoom;
  final List<Marker> markers;

  MapConfigData({
    required this.mapController,
    required this.center,
    required this.zoom,
    required this.markers,
  });
}

Widget buildFlutterMap(BuildContext context, MapConfigData mapConfig) {
  return FlutterMap(
    mapController: mapConfig.mapController,
    options: MapOptions(
      initialCenter: mapConfig.center,
      initialZoom: mapConfig.zoom,
      interactionOptions: const InteractionOptions(
        flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      // If you want to pass onPositionChanged from MapScreen -> MapViewModel -> here:
      // onPositionChanged: (MapPosition position, bool hasGesture) {
      //   // Call a callback passed in via mapConfig if needed
      // },
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.adventure_app',
      ),
      if (mapConfig.markers.isNotEmpty) MarkerLayer(markers: mapConfig.markers),
      RichAttributionWidget(
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            onTap: () async {
              final Uri url = Uri.parse('https://openstreetmap.org/copyright');
              if (!await launchUrl(url)) {
                print('Could not launch $url');
                // TODO: Maybe a snackbar here
              }
            },
          ),
        ],
        alignment: AttributionAlignment.bottomLeft,
      ),
    ],
  );
}
