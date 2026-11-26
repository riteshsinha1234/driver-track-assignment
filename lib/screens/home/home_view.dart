import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/text.dart';
import 'package:driver_track/components/widget.dart';
import 'package:driver_track/screens/home/home_bloc.dart';
import 'package:driver_track/screens/home/home_event.dart';
import 'package:driver_track/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadHomeData());
    });

    return customBody(
      appBar: customAppBar("Home Screen", white),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: customTxt(state.message, 20, grn, FontWeight.w700),
                ),
                gapH(50),
                GestureDetector(
                  onTap: () {
                    // routePush(ProfileView());
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: customTxt(
                      "Profile Screen",
                      20,
                      grn,
                      FontWeight.w700,
                    ),
                  ),
                ),
                gapH(30),
                GestureDetector(
                  onTap: () {
                    // routePush(FindDoctorView());
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: customTxt(
                      "Find Doctor (click)",
                      20,
                      grn,
                      FontWeight.w700,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is HomeError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: customTxt(
                    "Error: ${state.error}",
                    18,
                    Colors.red,
                    FontWeight.w600,
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
