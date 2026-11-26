import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/routers.dart';
import 'package:driver_track/components/text.dart';
import 'package:driver_track/components/widget.dart';
import 'package:driver_track/screens/home/home_view.dart';
import 'package:driver_track/screens/splash/splash_bloc.dart';
import 'package:driver_track/screens/splash/splash_event.dart';
import 'package:driver_track/screens/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashBloc>().add(StartSplash());
    });

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          routePushReplacement(HomeView());
        }
      },
      child: customBody(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: customTxt("Splash Screen", 20, grn, FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
