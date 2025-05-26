import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:adventure_app/features/map/widgets/map_builder.dart';

// TODO: use activity and location fetchers here

class MapViewModel {
  final MapController mapController = MapController();

  // Default initial values
  final LatLng _initialCenter = const LatLng(45.3019, -122.9730);
  final double _initialZoom = 13.0;
  final List<Marker> _initialMarkers =
      []; // Start with no markers for simplicity

  // Using ValueNotifier to hold the MapConfigData so UI can react if it changes
  late final ValueNotifier<MapConfigData> mapConfigNotifier;

  MapViewModel() {
    mapConfigNotifier = ValueNotifier(
      MapConfigData(
        mapController: mapController,
        center: _initialCenter,
        zoom: _initialZoom,
        markers: _initialMarkers,
      ),
    );
  }

  void centerMapOnDefault() {
    mapController.move(_initialCenter, _initialZoom);
  }

  void addDemoMarker() {
    final newMarkers = List<Marker>.from(mapConfigNotifier.value.markers);
    newMarkers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(
          _initialCenter.latitude + 0.01,
          _initialCenter.longitude + 0.01,
        ),
        child: const Column(
          children: [
            Icon(Icons.location_pin, color: Colors.red, size: 40),
            Text("Demo", style: TextStyle(fontSize: 10, color: Colors.black)),
          ],
        ),
      ),
    );
    mapConfigNotifier.value = MapConfigData(
      // Create a new instance
      mapController: mapController,
      center: mapConfigNotifier.value.center,
      zoom: mapConfigNotifier.value.zoom,
      markers: newMarkers,
    );
  }

  void dispose() {
    mapConfigNotifier.dispose();
  }
}
