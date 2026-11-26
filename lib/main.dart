import 'package:driver_track/components/bloc/bloc_provider.dart';
import 'package:driver_track/components/bloc/theme/theme_bloc.dart';
import 'package:driver_track/components/bloc/theme/theme_state.dart';
import 'package:driver_track/components/routers.dart';
import 'package:driver_track/screens/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
    );
  }
}
