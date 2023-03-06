part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isSearch;
  final Position position;
  final CameraPosition cameraPosition;
  final Set<Marker> markers;
  final bool update;
  final bool isShowDraggable;
  final SearchType searchType;

  const HomeState({
    this.searchType = SearchType.hospital,
    this.isShowDraggable = false,
    this.update = false,
    this.markers = const {},
    this.position = const Position(
      longitude: .0,
      latitude: .0,
      timestamp: null,
      accuracy: .0,
      altitude: .0,
      heading: .0,
      speed: .0,
      speedAccuracy: .0,
    ),
    this.cameraPosition = const CameraPosition(target: LatLng(.0, .0)),
    this.isSearch = false,
  });

  @override
  List<Object> get props => [
        isSearch,
        position,
        cameraPosition,
        markers,
        update,
        isShowDraggable,
        searchType,
      ];

  HomeState copyWith({
    Position? position,
    CameraPosition? cameraPosition,
    bool? isSearch,
    Set<Marker>? markers,
    bool? update,
    DraggableScrollableController? draggableController,
    bool? isShowDraggable,
    bool? isSearchResto,
    SearchType? searchType,
  }) {
    return HomeState(
      position: position ?? this.position,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      isSearch: isSearch ?? this.isSearch,
      markers: markers ?? this.markers,
      update: update ?? this.update,
      isShowDraggable: isShowDraggable ?? this.isShowDraggable,
      searchType: searchType ?? this.searchType,
    );
  }
}
