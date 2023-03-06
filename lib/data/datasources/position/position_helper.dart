import 'dart:async'; 
import 'package:flutter/services.dart'; 
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; 

class PositionHelper {
  static PositionHelper? _positionHelper;
  PositionHelper._instance() {
    _positionHelper = this;
  }
  factory PositionHelper() => _positionHelper ?? PositionHelper._instance();

  /// centering google map camera
  Future<void> centeringCamera(
    CameraPosition cameraPosition,
    Completer<GoogleMapController> completer,
  ) async {
    final controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  /// get current location by GPS
  Future<Position> determineMyPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  /// create a new mark for the place
  Future<Marker> generateNewMarker(LatLng place, void Function()? onTap) async {
    final bytes = await rootBundle.load('assets/marker.png');
    final icon = bytes.buffer.asUint8List();

    return Marker(
      icon: BitmapDescriptor.fromBytes(icon),
      markerId: const MarkerId("place"),
      position: place,
      onTap: onTap,
    );
  }

  /// make Position initiation
  Position newPosition({LatLng? latLng, Position? position}) => Position(
        latitude: latLng?.latitude ?? (position?.latitude ?? .0),
        longitude: latLng?.longitude ?? (position?.longitude ?? .0),
        timestamp: null,
        speedAccuracy: .0,
        accuracy: .0,
        altitude: .0,
        heading: .0,
        speed: .0,
      );

  /// make CameraPosition initiation
  CameraPosition newCam({LatLng? latLng, Position? position}) {
    return CameraPosition(
      zoom: 19,
      target: LatLng(
        latLng?.latitude ?? (position?.latitude ?? .0),
        latLng?.longitude ?? (position?.longitude ?? .0),
      ),
    );
  }
 
 
}
