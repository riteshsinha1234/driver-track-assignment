import 'package:driver_track/screens/home/home_bloc.dart';
import 'package:driver_track/screens/splash/splash_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProvider() {
  return [
    BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
    BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
  ];
}
