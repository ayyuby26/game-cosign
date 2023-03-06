import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/domain/entities/places.dart';
import '../../../common/failure.dart';
import '../../../common/state_enum.dart';
import '../../../domain/usecases/next_places_usecase.dart';
import '../../../domain/usecases/places_usecase.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesAbstractEvent, PlacesState> {
  final PlacesUsecase places;
  final NextPlacesUsecase nextPlaces;
  PlacesBloc(this.places, this.nextPlaces) : super(const PlacesState()) {
    on<PlacesEvent>(_event);
    on<PlacesNextEvent>(_nextPlaces);
  }
  var status = RequestState.initial;
  var message = '';

  /// search for places via API
  _event(PlacesEvent event, emit) async {
    status = RequestState.loading;
    emit(PlacesState(status: status, message: message));
    Either<Failure, Places>? result;

    result = await places.execute(event.place, event.latLng, event.searchType);

    result.fold((l) {
      status = RequestState.failure;
      message = l.message;
      emit(PlacesState(status: status, message: message));
    }, (r) {
      status = r.status == null ? RequestState.failure : RequestState.success;

      emit(PlacesState(
        status: status,
        message: message,
        result: r,
      ));
    });
  }

  /// search for the next place via API
  _nextPlaces(PlacesNextEvent event, Emitter<PlacesState> emit) async {
    status = RequestState.loading;
    final currentresults = state.result.results!;
    emit(PlacesState(status: status, message: message, result: state.result));

    final result = await nextPlaces.execute(event.pageToken);

    result.fold((l) {
      status = RequestState.failure;
      message = l.message;
      emit(PlacesState(status: status, message: message));
    }, (r) {
      status = RequestState.success;
      final data = currentresults + r.results!;
      final data2 = Places(
        htmlAttributions: r.htmlAttributions,
        nextPageToken: r.nextPageToken,
        results: data,
        status: r.status,
      );
      emit(PlacesState(status: status, message: message, result: data2));
    });
  }
}
