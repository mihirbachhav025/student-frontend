import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';

class LocationService extends GetxService {
  Location location = Location();
  FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://attendance-app-b667e-default-rtdb.firebaseio.com/');

  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> startLocationService(String userId) async {
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception('Location permission denied');
      }
    }

    _locationSubscription = location.onLocationChanged.listen((locationData) {
      print('_locationSubscription onChage called');
      print(locationData.toString());
      _updateDatabase(userId, locationData);
    });
  }

  void _updateDatabase(String userId, LocationData locationData) async {
    print('uodate db called');
    print(userId);
    DatabaseReference databaseRef = database.ref('users');
    print(databaseRef.key);
    databaseRef.child(userId).push().set({
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
