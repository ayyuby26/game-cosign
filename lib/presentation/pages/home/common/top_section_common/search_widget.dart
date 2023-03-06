import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../common/utils.dart';
import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/places/places_bloc.dart'; 

class SearchWidget extends StatelessWidget {
  final _ctrlSearch = TextEditingController();
  final FocusNode focusNode;
  SearchWidget(this.focusNode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: state.isSearch ? 1 : .0,
              child: Container(
                color: state.isSearch ? Colors.white : Colors.transparent,
                width: width,
                height: state.isSearch ? statBarHeight(context) + 71 : 0,
                padding: const EdgeInsets.all(16),
              ),
            );
          },
        ),
        Container(
          height: statBarHeight(context) + 70,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            children: [
              SizedBox(height: statBarHeight(context), width: width),
              _SearchBar(ctx: context, ctrl: _ctrlSearch, focusNode: focusNode),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final BuildContext ctx;
  final TextEditingController ctrl;
  final FocusNode focusNode;

  const _SearchBar({
    required this.ctx,
    required this.ctrl,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    final placesBloc = context.read<PlacesBloc>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return TextField(
            onTap: () {
              homeBloc.add(const HomeIsFocusChanged(isSearchShow: true));
            },
            controller: ctrl,
            onSubmitted: (value) {
              final latlng = LatLng(
                homeBloc.state.position.latitude,
                homeBloc.state.position.longitude,
              );
              homeBloc.add(HomeReset());
              placesBloc.add(PlacesEvent(
                place: ctrl.text,
                latLng: latlng,
                searchType: homeBloc.state.searchType,
              ));
            },
            focusNode: focusNode,
            style: const TextStyle(height: 1.2),
            strutStyle: StrutStyle.fromTextStyle(const TextStyle(height: 1.2)),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  color: Colors.black26,
                  height: 1.2,
                  fontWeight: FontWeight.normal),
              prefixIcon: InkWell(
                onTap: () {
                  focusNode.unfocus();
                  homeBloc.add(const HomeIsFocusChanged(isSearchShow: false));
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return Icon(
                      state.isSearch ? Icons.arrow_back : Icons.search,
                      color: Colors.blue,
                    );
                  },
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 40,
                maxHeight: 40,
                minWidth: 50,
              ),
              hintText: "Search ${state.searchType.name}...",
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: const Color(0xFFffffff),
              filled: true,
            ),
          );
        },
      ),
    );
  }
}
