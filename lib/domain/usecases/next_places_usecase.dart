import 'package:dartz/dartz.dart';
import 'package:maps/domain/entities/places.dart';
import 'package:maps/domain/repositories/places_repository.dart';
import '../../common/failure.dart';

class NextPlacesUsecase {
  final PlacesRepository repository;
  NextPlacesUsecase(this.repository);

  Future<Either<Failure, Places>> execute(String pageToken) =>
      repository.getNextPlaces(pageToken);
}
