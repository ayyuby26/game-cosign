import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/common/state_enum.dart';
import 'package:maps/data/datasources/position/position_helper.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PositionHelper helper;

  HomeBloc({required this.helper}) : super(const HomeState()) {
    on<HomeGetMyPosition>(_getMyPosition);
    on<HomeMoveCameraEvent>(_moveCamera);
    on<HomeIsFocusChanged>(_isFocusChaged);
    on<HomeAddMarkerEvent>(_addMarker);
    on<HomeShowDraggableEvent>(_showDraggable);
    on<HomeReset>(_reset);
    on<HomeChangeSearchType>(_changeSearchType);
  }

  var status = RequestState.initial;
  var message = '';

  /// get the current location and centralize it
  _getMyPosition(HomeGetMyPosition event, Emitter<HomeState> emit) async {
    final currentState = state;
    final position = await helper.determineMyPosition();
    final cam = helper.newCam(position: position);
    helper.centeringCamera(cam, event.completer);

    emit(currentState.copyWith(
      position: position,
      cameraPosition: cam,
      isShowDraggable: false,
      markers: {
        Marker(
          markerId: MarkerId(UniqueKey().toString()),
          position: LatLng(position.latitude, position.longitude),
          draggable: true,
          onDragEnd: (val) {
            helper.centeringCamera(
              CameraPosition(target: val, zoom: 19),
              event.completer,
            );
            event.context.read<HomeBloc>().add(HomeMoveCameraEvent(val));
          },
        )
      },
    ));
  }

  /// move the camera to the latest position
  _moveCamera(HomeMoveCameraEvent event, Emitter<HomeState> emit) async {
    final currentState = state;
    emit(currentState.copyWith(
      position: helper.newPosition(latLng: event.latLng),
      cameraPosition: helper.newCam(latLng: event.latLng),
      isShowDraggable: false,
    ));
  }

  /// update search status
  _isFocusChaged(HomeIsFocusChanged event, Emitter<HomeState> emit) {
    final currentState = state;
    emit(currentState.copyWith(isSearch: event.isSearchShow));
  }

  /// adding markers to google map
  _addMarker(HomeAddMarkerEvent event, Emitter<HomeState> emit) async {
    final hasMarker = state.markers.any((e) => e.markerId.value == "place");
    final newMarker = Set<Marker>.from(state.markers);
    if (hasMarker) newMarker.removeWhere((e) => e.markerId.value == 'place');
    newMarker.add(await helper.generateNewMarker(event.place, () {
      final home = event.context.read<HomeBloc>();
      home.add(HomeShowDraggableEvent());
    }));

    emit(state.copyWith(
      markers: newMarker,
      isSearch: false,
      isShowDraggable: true,
    ));
  }

  /// update state
  _showDraggable(HomeShowDraggableEvent event, Emitter<HomeState> emit) {
    final currentState = state;
    emit(currentState.copyWith(update: !state.update));
  }

  /// remove the place marker
  _reset(HomeReset event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      markers: {state.markers.first},
      isShowDraggable: false,
    ));
  }

  /// update search type
  _changeSearchType(HomeChangeSearchType event, Emitter<HomeState> emit) {
    final currentState = state;
    emit(currentState.copyWith(searchType: event.searchType));
  }
}
