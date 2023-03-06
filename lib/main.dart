import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:maps/presentation/bloc/places/places_bloc.dart';
import 'package:maps/presentation/pages/home/home_page.dart';

import 'app_bloc_observer.dart';
import 'common/constants.dart';
import 'injection.dart' as di;
import 'presentation/bloc/home/home_bloc.dart';

void main() {
  // depedency injection initiation
  di.init();

  // bloc observation initiation
  Bloc.observer = AppBlocObserver();

  // ensure using a Texture Layer Hybrid Composition,
  // for optimal performance as it only needs to display markers
  final mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }

  // running App
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: colorPrimary,
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.locator<HomeBloc>()),
          BlocProvider(create: (context) => di.locator<PlacesBloc>()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
