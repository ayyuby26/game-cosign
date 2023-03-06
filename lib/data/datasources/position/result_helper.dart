import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils.dart';
import '../../../presentation/bloc/home/home_bloc.dart';
import '../../../presentation/bloc/places/places_bloc.dart';
import '../../models/places_model.dart';

class ResultHelper {
  static ResultHelper? _positionHelper;
  ResultHelper._instance() {
    _positionHelper = this;
  }
  factory ResultHelper() => _positionHelper ?? ResultHelper._instance();

 /// get the data according to the last position
  ResultModel? data(BuildContext context) {
    ResultModel? result;
    try {
      final home = context.read<HomeBloc>().state;
      final places = context.read<PlacesBloc>().state;
      final here = home.markers.last.position;
      result = (places.result.results ?? []).firstWhere((e) =>
          e.geometry?.location?.lat == here.latitude &&
          e.geometry?.location?.lng == here.longitude);
    } catch (e) {
      printError(e);
    }
    return result;
  }
}
