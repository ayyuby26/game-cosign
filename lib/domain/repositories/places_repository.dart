import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common/failure.dart';
import '../../common/state_enum.dart';
import '../entities/places.dart';

abstract class PlacesRepository {
  Future<Either<Failure, Places>> getPlaces(String place, LatLng latLng, SearchType searchType);
  Future<Either<Failure, Places>> getNextPlaces(String pageToken);
}
