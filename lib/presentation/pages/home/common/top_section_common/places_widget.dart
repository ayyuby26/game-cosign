import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../common/state_enum.dart';
import '../../../../../common/utils.dart';
import '../../../../../common/widgets/guide.dart';
import '../../../../../common/widgets/loading.dart';
import '../../../../../data/datasources/position/position_helper.dart';
import '../../../../../data/models/places_model.dart';
import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/places/places_bloc.dart';

class PlacesWidget extends StatelessWidget {
  final FocusNode focusNode;
  final Completer<GoogleMapController> ctrlGmaps;
  final ctrlScroll = ScrollController();

  PlacesWidget(this.focusNode, this.ctrlGmaps, {super.key});

  @override
  Widget build(BuildContext context) {
    _scrollListener(context);
    return Expanded(
      child: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: state.isSearch ? 1 : .0,
                child: SizedBox(
                  width: width,
                  height: state.isSearch ? height : 0,
                  child: Material(
                    color: Colors.white,
                    child: _placesBody(context),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _placesBody(BuildContext context) {
    return BlocListener<PlacesBloc, PlacesState>(
      listener: (context, state) {
        if (state.status == RequestState.failure) {
          const snackBar = SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text('Failed to get data!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
          if (state.status == RequestState.initial) {
            return const Guide();
          } else if (state.status == RequestState.loading &&
              state.result.results == null) {
            return const Loading();
          }

          return _placesList(context, state);
        },
      ),
    );
  }

  /// if the scroll is at the bottom it will call the next page api
  void _scrollListener(BuildContext context) {
    ctrlScroll.addListener(() {
      if (!ctrlScroll.position.atEdge) return;
      bool isScrollOnTop = ctrlScroll.position.pixels == 0;
      if (isScrollOnTop) return;
      final places = context.read<PlacesBloc>();
      final isSuccess = places.status == RequestState.success;
      final isNextPageAvailable = places.state.result.nextPageToken != null;
      if (isSuccess && isNextPageAvailable) {
        places.add(PlacesNextEvent("${places.state.result.nextPageToken}"));
      }
    });
  }

  Widget _placesList(BuildContext context, PlacesState state) {
    var places = state.result.results ?? [];
    final placesWidget = places.map((e) => _placeItem(e, context)).toList();
    if (state.result.nextPageToken != null) placesWidget.add(const Loading());
    placesWidget.add(const SizedBox(height: 16));
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      controller: ctrlScroll,
      children: placesWidget,
    );
  }

  Widget _placeItem(ResultModel e, BuildContext context) {
    return InkWell(
      onTap: () {
        focusNode.unfocus();
        Future.delayed(const Duration(milliseconds: 200), () {
          final homeBloc = context.read<HomeBloc>();
          final loc = e.geometry?.location;
          final latLng = LatLng(loc?.lat ?? .0, loc?.lng ?? .0);
          homeBloc.add(HomeAddMarkerEvent(latLng, context));
          PositionHelper().centeringCamera(
            CameraPosition(target: latLng, zoom: 19),
            ctrlGmaps,
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text("${e.name}"),
                  Text(
                    "${e.vicinity}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: width,
                    height: 1,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
            const Icon(Icons.directions)
          ],
        ),
      ),
    );
  }
}
