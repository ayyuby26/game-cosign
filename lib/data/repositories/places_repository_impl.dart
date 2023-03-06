import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/domain/entities/places.dart';

import 'package:maps/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:maps/domain/repositories/places_repository.dart';

import '../../common/exception.dart';
import '../../common/state_enum.dart'; 
import '../datasources/places.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesDataSource dataSource;

  const PlacesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Places>> getPlaces(String place, LatLng latLng, SearchType searchType) async {
    try {
      final result = await dataSource.places(place, latLng, searchType);
      return Right(result.toEntity()); 
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
  @override
  Future<Either<Failure, Places>> getNextPlaces(String pageToken) async {
    try {
      final result = await dataSource.nextPlaces(pageToken);
      return Right(result.toEntity()); 
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
