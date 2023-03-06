import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../bloc/home/home_bloc.dart';
import 'common/draggable_sheet.dart';
import 'common/maps.dart';
import 'package:flutter/material.dart'; 
import 'common/top_section.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final completer = Completer<GoogleMapController>();
  final draggableController = DraggableScrollableController();

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeGetMyPosition(completer, context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Maps(completer),
          DraggableSheet(draggableController),
          TopSection(completer),
        ],
      ),
    );
  }
}
