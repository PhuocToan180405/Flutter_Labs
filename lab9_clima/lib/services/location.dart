import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  /// Lấy vị trí GPS hiện tại của người dùng
  Future<bool> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;
      return true;
    } catch (e) {
      // Khi không lấy được vị trí (thiết bị giả lập, desktop, hoặc người dùng từ chối quyền)
      return false;
    }
  }
}
