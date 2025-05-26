import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllActivities() async {
    final response = await supabase
        .from('activities')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getActivitiesNearby({
    required double userLatitude,
    required double userLongitude,
    double maxDistanceMi = 10.0,
  }) async {
    // Fetch all activities
    // TODO: optimize later
    final allActivities = await getAllActivities();

    final nearbyActivities =
        allActivities.where((activity) {
          // Ensure latitude and longitude are not null and are valid doubles
          final double? lat =
              activity['latitude'] is double
                  ? activity['latitude']
                  : double.tryParse(activity['latitude'].toString());
          final double? lon =
              activity['longitude'] is double
                  ? activity['longitude']
                  : double.tryParse(activity['longitude'].toString());

          if (lat == null || lon == null) {
            print(
              'Warning: Skipping activity with invalid coordinates: ${activity['name'] ?? 'Unknown'}',
            );
            return false; // Skip if coordinates are invalid
          }

          final distance = _calculateDistance(
            userLatitude,
            userLongitude,
            lat,
            lon,
          );
          return distance <= maxDistanceMi;
        }).toList();

    return nearbyActivities;
  }

  Future<Map<String, dynamic>?> getRandomActivityNearby({
    required double userLatitude,
    required double userLongitude,
    double maxDistanceMi = 10.0,
  }) async {
    final nearby = await getActivitiesNearby(
      userLatitude: userLatitude,
      userLongitude: userLongitude,
      maxDistanceMi: maxDistanceMi,
    );

    if (nearby.isEmpty) return null;
    return nearby[Random().nextInt(nearby.length)];
  }

  double _calculateDistance(
    double latitude1,
    double longitude1,
    double latitude2,
    double longitude2,
  ) {
    const earthRadius = 3963.1; // Earth radius in miles
    final deltaLat = _degreesToRadians(latitude2 - latitude1);
    final deltaLon = _degreesToRadians(longitude2 - longitude1);

    final a =
        sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(_degreesToRadians(latitude1)) *
            cos(_degreesToRadians(latitude2)) *
            sin(deltaLon / 2) *
            sin(deltaLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) => degrees * pi / 180.0;
}
