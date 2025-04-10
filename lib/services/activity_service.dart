import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityService {
  final supabase = Supabase.instance.client;

  /// Fetch all activities (for admin/testing, optional)
  Future<List<Map<String, dynamic>>> getAllActivities() async {
    final response = await supabase
        .from('activities')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get a random activity within a specified distance
  Future<Map<String, dynamic>?> getRandomActivityNearby({
    required double userLatitude,
    required double userLongitude,
    double maxDistanceMi = 10.0,
  }) async {
    final response = await supabase.from('activities').select();
    final all = List<Map<String, dynamic>>.from(response);

    final nearby =
        all.where((activity) {
          final double lat = double.tryParse('${activity['latitude']}') ?? 0;
          final double long = double.tryParse('${activity['longitude']}') ?? 0;

          final distance = _calculateDistance(
            userLatitude,
            userLongitude,
            lat,
            long,
          );

          print('📍 $lat, $long → distance = $distance mi');

          return distance <= maxDistanceMi;
        }).toList();

    print('🎯 Nearby count: ${nearby.length}');

    if (nearby.isEmpty) return null;
    return nearby[Random().nextInt(nearby.length)];
  }

  /// Haversine distance calculation (in miles)
  double _calculateDistance(
    double latitude1,
    double longitude1,
    double latitude2,
    double longitude2,
  ) {
    const earthRadius = 3963.1;
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
