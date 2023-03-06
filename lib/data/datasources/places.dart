import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common/base_url.dart';
import '../../common/state_enum.dart';
import '../models/places_model.dart';

abstract class PlacesDataSource {
  Future<PlacesModel> places(
      String place, LatLng latLng, SearchType searchType);
  Future<PlacesModel> nextPlaces(String pageToken);
}

class PlacesDataSourceImpl implements PlacesDataSource {
  final Dio dio;

  PlacesDataSourceImpl({required this.dio});

  @override
  Future<PlacesModel> places(
      String place, LatLng latLng, SearchType searchType) async {
    try {
      final response = await dio.get(urlPlaces(place, latLng, searchType));
      if (response.statusCode == 200) {
        return PlacesModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint("PlacesApiData: ${e.response!.data}");
        debugPrint("PlacesApiHeaders: ${e.response!.headers}");
        debugPrint("PlacesApiOptions: ${e.response!.requestOptions}");
      } else {
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
    }
    return PlacesModel();
  }

  @override
  Future<PlacesModel> nextPlaces(String pageToken) async {
    try {
      final response = await dio.get(urlNextPlaces(pageToken));
      if (response.statusCode == 200) {
        return PlacesModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint("PlacesApiData: ${e.response!.data}");
        debugPrint("PlacesApiHeaders: ${e.response!.headers}");
        debugPrint("PlacesApiOptions: ${e.response!.requestOptions}");
      } else {
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
    }
    return PlacesModel();
  }
}
