part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  final bool isSearchShow;
  const HomeEvent({this.isSearchShow = false});

  @override
  List<Object> get props => [isSearchShow];
}

class HomeGetMyPosition extends HomeEvent {
  final Completer<GoogleMapController> completer;
  final BuildContext context;

  final bool isFromBtn;
  const HomeGetMyPosition(
    this.completer,
    this.context, {
    this.isFromBtn = false,
  });

  @override
  List<Object> get props => [isSearchShow, completer, context];
}

class HomeMoveCameraEvent extends HomeEvent {
  final LatLng latLng;

  const HomeMoveCameraEvent(this.latLng);

  @override
  List<Object> get props => [isSearchShow, latLng];
}

class HomeIsFocusChanged extends HomeEvent {
  const HomeIsFocusChanged({required super.isSearchShow});

  @override
  List<Object> get props => [isSearchShow];
}

class HomeAddMarkerEvent extends HomeEvent {
  final LatLng place;
  final BuildContext context;

  const HomeAddMarkerEvent(this.place, this.context);

  @override
  List<Object> get props => [isSearchShow, place];
}

class HomeShowDraggableEvent extends HomeEvent {}

class HomeReset extends HomeEvent {}

class HomeChangeSearchType extends HomeEvent {
  final SearchType searchType;

  const HomeChangeSearchType(this.searchType);

  @override
  List<Object> get props => [isSearchShow, searchType];
}

class HomeUpdateDraggableHeight extends HomeEvent {
  final double draggableheight;

  const HomeUpdateDraggableHeight(this.draggableheight);
  @override
  List<Object> get props => [isSearchShow, draggableheight];
}
