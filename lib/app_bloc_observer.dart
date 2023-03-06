import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/common/utils.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    printWhite("${bloc.runtimeType}");
  }
}
