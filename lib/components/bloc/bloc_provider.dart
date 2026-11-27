import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/location/connectivity_service.dart';
import '../../data/location/location_service.dart';
import '../../data/location/location_storage.dart';
import '../../data/remote/location_api.dart';
import '../../data/repositories/location_repository.dart';
import '../../screens/home/home_bloc.dart';
import '../../screens/splash/splash_bloc.dart';
import '../../screens/tracking/tracking_bloc.dart';
import '../../screens/bottom_navigation/bottom_navigation_bloc.dart';

List<RepositoryProvider> repositoryProviders(LocationStorage storage) {
  return [
    RepositoryProvider<LocationRepository>(
      create: (context) => LocationRepository(
        locationService: LocationService(),
        connectivityService: ConnectivityService(),
        locationStorage: storage,
        locationApi: LocationApi(),
      ),
      dispose: (repository) => repository.dispose(),
    ),
  ];
}

List<BlocProvider> blocProvider() {
  return [
    BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
    BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc(locationRepository: context.read<LocationRepository>()),
    ),
    BlocProvider<TrackingBloc>(
      create: (context) =>
          TrackingBloc(locationRepository: context.read<LocationRepository>()),
    ),
    BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(),
    ),
  ];
}
