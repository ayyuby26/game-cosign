import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; 
import '../../../../common/utils.dart';
import '../../../bloc/home/home_bloc.dart';

class Maps extends StatelessWidget {
  final Completer<GoogleMapController> completer;
  const Maps(this.completer, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.markers.isNotEmpty) return _gMap(state, context);
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _gMap(HomeState state, BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          markers: state.markers,
          onCameraMove: unfocus,
          onCameraMoveStarted: unfocus,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: state.cameraPosition,
          onMapCreated: completer.complete,
        ),
        Positioned(right: 16, bottom: 16, child: _FloatBtn(completer))
      ],
    );
  }
}

class _FloatBtn extends StatelessWidget {
  final Completer<GoogleMapController> completer;
  const _FloatBtn(this.completer);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.isSearch
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () => onPress(context),
                child: const Icon(Icons.my_location),
              );
      },
    );
  }

  void onPress(BuildContext context) {
    context.read<HomeBloc>().add(HomeGetMyPosition(completer, context));
  }
}
