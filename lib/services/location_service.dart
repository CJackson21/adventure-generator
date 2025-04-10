import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // Error when the location services are disabled
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    // First check for permissions
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // Second and final check for permissions
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Locations permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Location services are enabled and proper permissions are granted
    return await Geolocator.getCurrentPosition();
  }
}
