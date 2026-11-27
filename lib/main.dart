import 'package:driver_track/components/bloc/bloc_provider.dart';
import 'package:driver_track/components/bloc/theme/theme_bloc.dart';
import 'package:driver_track/components/bloc/theme/theme_state.dart';
import 'package:driver_track/components/routers.dart';
import 'package:driver_track/data/location/location_storage.dart';
import 'package:driver_track/screens/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final locationStorage = LocationStorage();
  await locationStorage.init();

  runApp(MyApp(locationStorage: locationStorage));
}

class MyApp extends StatefulWidget {
  final LocationStorage? locationStorage;

  const MyApp({super.key, this.locationStorage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static LocationStorage? _testStorage;
  late final Future<LocationStorage> _storageFuture;

  @override
  void initState() {
    super.initState();
    _storageFuture = _initializeStorage();
  }

  Future<LocationStorage> _initializeStorage() async {
    if (widget.locationStorage != null) {
      return widget.locationStorage!;
    }

    _testStorage ??= LocationStorage();

    await _testStorage!.init();

    return _testStorage!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationStorage>(
      future: _storageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Storage initialization failed: ${snapshot.error}'),
              ),
            ),
          );
        }

        final storage = snapshot.data!;

        return MultiRepositoryProvider(
          providers: repositoryProviders(storage),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
              ...blocProvider(),
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Sizer(
                  builder: (context, orientation, deviceType) {
                    return MaterialApp(
                      navigatorKey: navigatorKey,
                      debugShowCheckedModeBanner: false,
                      title: 'Driver Track',
                      theme: state.themeData,
                      home: const SplashView(),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
