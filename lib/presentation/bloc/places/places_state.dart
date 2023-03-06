part of 'places_bloc.dart';

class PlacesState extends Equatable {
  final String message;
  final RequestState status;
  final Places result;
  const PlacesState({
    this.message = '',
    this.result = const Places(),
    this.status = RequestState.initial,
  });

  @override
  List<Object> get props => [message, status, result];
}
