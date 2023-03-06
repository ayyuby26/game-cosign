part of 'places_bloc.dart';

abstract class PlacesAbstractEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlacesEvent extends PlacesAbstractEvent {
  final String place;
  final LatLng latLng;
  final SearchType searchType;

  PlacesEvent({
    required this.place,
    required this.latLng,
    required this.searchType,
  });

  @override
  List<Object> get props => [place, latLng, searchType];
}

class PlacesNextEvent extends PlacesAbstractEvent {
  final String pageToken;

  PlacesNextEvent(this.pageToken);
  @override
  List<Object?> get props => [pageToken];
}
