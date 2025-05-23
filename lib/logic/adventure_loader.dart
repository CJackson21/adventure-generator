import 'dart:developer';
import 'package:adventure_app/core/services/location_service.dart';
import 'package:adventure_app/core/services/activity_service.dart';

class AdventureLoader {
  static Future<Map<String, dynamic>?> load() async {
    try {
      final position = await LocationService().getCurrentLocation();
      final activity = await ActivityService().getRandomActivityNearby(
        userLatitude: position.latitude,
        userLongitude: position.longitude,
      );
      return activity;
    } catch (error) {
      log('Error loading adventure: $error');
      return null;
    }
  }
}
