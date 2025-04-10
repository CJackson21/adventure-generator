import 'dart:developer';
import 'package:adventure_app/services/location_service.dart';
import 'package:adventure_app/services/activity_service.dart';

class AdventureLoader {
  static Future<Map<String, dynamic>?> load() async {
    try {
      final position = await LocationService().getCurrentLocation();
      final activity = await ActivityService().getRandomActivityNearby(
        userLatitude: position.latitude,
        userLongitude: position.longitude,
      );
      print(position);
      print(activity);
      return activity;
    } catch (error) {
      log('Error loading adventure: $error');
      return null;
    }
  }
}
