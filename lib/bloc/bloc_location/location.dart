import 'package:geolocator/geolocator.dart';

class Location {
  static Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permiso de localización denegado.');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getCurrentLocation() async {
    Position position = await determinePosition();
    print(position.latitude);
    print(position.longitude);
    return position;
  }
}
