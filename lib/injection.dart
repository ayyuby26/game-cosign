import 'package:get_it/get_it.dart';
import 'package:maps/common/dio_config.dart';

import 'package:maps/presentation/bloc/home/home_bloc.dart';
import 'package:maps/presentation/bloc/places/places_bloc.dart';
import 'data/datasources/places.dart';
import 'data/datasources/position/position_helper.dart';
import 'data/repositories/places_repository_impl.dart';
import 'domain/repositories/places_repository.dart';
import 'domain/usecases/next_places_usecase.dart';
import 'domain/usecases/places_usecase.dart';

final locator = GetIt.instance;
void init() {
  // provider
  locator.registerFactory(() => HomeBloc(helper: locator()));
  locator.registerFactory(() => PlacesBloc(locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => PlacesUsecase(locator()));
  locator.registerLazySingleton(() => NextPlacesUsecase(locator()));

  // repository
  locator.registerLazySingleton<PlacesRepository>(
    () => PlacesRepositoryImpl(dataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<PlacesDataSource>(
    () => PlacesDataSourceImpl(
      dio: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton(() => PositionHelper());

  // external
  locator.registerLazySingleton(() => dio);
}
