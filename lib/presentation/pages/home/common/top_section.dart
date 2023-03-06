import 'dart:async';
import 'package:flutter/material.dart';   
import 'top_section_common/places_widget.dart';
import 'top_section_common/filter_widget.dart';
import 'top_section_common/search_widget.dart'; 
import 'package:google_maps_flutter/google_maps_flutter.dart'; 

class TopSection extends StatelessWidget {
  final Completer<GoogleMapController> ctrlGmaps;
  final _focusNode = FocusNode();

  TopSection(this.ctrlGmaps, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SearchWidget(_focusNode),
            const FilterWidget(),
            PlacesWidget(_focusNode, ctrlGmaps)
          ],
        ),
      ],
    );
  }
}


