import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';

class LocationService extends GetxService {
  final Location location = Location();

  final database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://attendance-app-b667e-default-rtdb.firebaseio.com/')
      .ref();

  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> startLocationService(String userId) async {
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception('Location permission denied');
      }
    }
    location.enableBackgroundMode(enable: true);
    _locationSubscription = location.onLocationChanged.listen((locationData) {
      print('_locationSubscription onChange called');
      _updateDatabase(userId, locationData);
    });
  }

  void _updateDatabase(String userId, LocationData locationData) async {
    String path = userId;
    final userIdRef = database.child(path);
    print(userId);
    userIdRef.set({
      'latitude': locationData.latitude,
      'longitude': locationData.longitude,
      'altitude': locationData.altitude,
      'timestamp': ServerValue.timestamp
    });
  }

  @override
  void onClose() {
    super.onClose();
    _locationSubscription?.cancel();
  }
}
