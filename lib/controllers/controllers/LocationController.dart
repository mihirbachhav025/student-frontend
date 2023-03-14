import 'package:get/get.dart';
import 'package:location/location.dart';
import '../service/location_service.dart';

class LocationController extends GetxController {
  final LocationService _locationService = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> startLocationRecording(String userId) async {
    try {
      await _locationService.startLocationService(userId);
      _locationService.location.onLocationChanged.listen((locationData) {
        _updateCurrentLocation(locationData);
      });
    } catch (e) {
      print('Error starting location service: $e');
    }
  }

  void _updateCurrentLocation(LocationData locationData) {
    // Perform any other necessary operations with the updated location data
  }

  @override
  void onClose() {
    super.onClose();
  }
}
