import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;

class LocationService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  Future<void> saveUserLocation(Position position, String userId) async {

    await firestore.collection('users').doc(userId).set({
      'latitude': position.latitude,
      'longitude': position.longitude,
    }, SetOptions(merge: true));
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<DocumentSnapshot>> getUsersWithinRadius(double radius) async {
    Position currentPosition = await getCurrentLocation();
    double currentLat = currentPosition.latitude;
    double currentLon = currentPosition.longitude;

    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<DocumentSnapshot> allUsers = querySnapshot.docs;

    List<DocumentSnapshot> usersWithinRadius = allUsers.where((doc) {
      var data = doc.data() as Map<String, dynamic>;
      double userLat = data['latitude'] as double;
      double userLon = data['longitude'] as double;
      double distance = calculateDistance(currentLat, currentLon, userLat, userLon);
      return distance <= radius;
    }).toList();

    return usersWithinRadius;
  }

}
