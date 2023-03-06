import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/domain/entities/places.dart';
import 'package:maps/domain/repositories/places_repository.dart';
import '../../common/failure.dart';
import '../../common/state_enum.dart';

class PlacesUsecase {
  final PlacesRepository repository;
  PlacesUsecase(this.repository);

  Future<Either<Failure, Places>> execute(String place, LatLng latLng, SearchType searchType) =>
      repository.getPlaces(place, latLng, searchType);
}
