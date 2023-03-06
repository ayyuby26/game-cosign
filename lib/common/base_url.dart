import 'state_enum.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const baseUrl = "https://maps.googleapis.com/maps/api";

String urlPlaces(String place, LatLng latLng, SearchType searchType) =>
    "/place/nearbysearch/json?keyword=$place&location=${latLng.latitude}%2C${latLng.longitude}&radius=20000&type=${searchType.name}";

String urlNextPlaces(String pageToken) =>
    "/place/nearbysearch/json?pagetoken=$pageToken";

String urlPhoto(String photoRef) {
  const apiKey = String.fromEnvironment('API_KEY');
  return "$baseUrl/place/photo?maxwidth=400&photo_reference=$photoRef&key=$apiKey";
}
