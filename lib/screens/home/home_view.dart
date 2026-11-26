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
      final bloc = context.read<HomeBloc>();

      if (bloc.state is HomeInitial) {
        bloc.add(LoadHomeData());
      }
    });

    return customBody(
      backgroundColor: iceWhite,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: electricBlue),
            );
          }

          if (state is HomeError) {
            return Center(
              child: customTxt(
                "Error: ${state.error}",
                16,
                red,
                FontWeight.w600,
              ),
            );
          }

          if (state is HomeLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customTxt(
                                    "Welcome Back,",
                                    14,
                                    blueGrey,
                                    FontWeight.w500,
                                  ),
                                  gapH(5),
                                  customTxt(
                                    "DriverTrack",
                                    24,
                                    navyBlue,
                                    FontWeight.w800,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          gapH(20),

                          // Tracking Status
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [navyBlue, darkBlue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: navyBlue.withValues(alpha: 0.15),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 9,
                                      width: 9,
                                      decoration: const BoxDecoration(
                                        color: cyan,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    gapW(8),
                                    customTxt(
                                      "TRACKING OVERVIEW",
                                      11,
                                      splashText,
                                      FontWeight.w600,
                                      letterSpacing: 1.5,
                                    ),
                                  ],
                                ),

                                gapH(20),

                                customTxt(
                                  "Your Drivers,",
                                  23,
                                  white,
                                  FontWeight.w700,
                                ),

                                gapH(5),

                                customTxt(
                                  "Your Business, Under Control.",
                                  13,
                                  blueGrey,
                                  FontWeight.w400,
                                ),

                                gapH(25),

                                Row(
                                  children: [
                                    Expanded(
                                      child: overviewItem(
                                        Icons.people_alt_outlined,
                                        "Total Drivers",
                                        "0",
                                      ),
                                    ),
                                    Container(
                                      height: 48,
                                      width: 1,
                                      color: white.withValues(alpha: 0.15),
                                    ),
                                    Expanded(
                                      child: overviewItem(
                                        Icons.location_on_outlined,
                                        "Active Drivers",
                                        "0",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          gapH(20),

                          // Section heading
                          customTxt(
                            "Quick Overview",
                            18,
                            navyBlue,
                            FontWeight.w700,
                          ),

                          gapH(15),

                          // Statistics
                          Row(
                            children: [
                              Expanded(
                                child: statCard(
                                  Icons.directions_car_outlined,
                                  "Total Trips",
                                  "0",
                                  electricBlue,
                                ),
                              ),
                              gapW(12),
                              Expanded(
                                child: statCard(
                                  Icons.route_outlined,
                                  "Total Distance",
                                  "0 km",
                                  splashCyan,
                                ),
                              ),
                            ],
                          ),

                          gapH(12),

                          Row(
                            children: [
                              Expanded(
                                child: statCard(
                                  Icons.check_circle_outline,
                                  "Completed",
                                  "0",
                                  grn,
                                ),
                              ),
                              gapW(12),
                              Expanded(
                                child: statCard(
                                  Icons.pending_actions_outlined,
                                  "Pending",
                                  "0",
                                  orang,
                                ),
                              ),
                            ],
                          ),

                          gapH(20),

                          // Quick Actions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customTxt(
                                "Quick Actions",
                                18,
                                navyBlue,
                                FontWeight.w700,
                              ),
                              customTxt(
                                "View All",
                                12,
                                electricBlue,
                                FontWeight.w600,
                              ),
                            ],
                          ),

                          gapH(15),

                          Row(
                            children: [
                              Expanded(
                                child: actionCard(
                                  Icons.person_add_alt_1_rounded,
                                  "Add Driver",
                                  electricBlue,
                                ),
                              ),
                              gapW(12),
                              Expanded(
                                child: actionCard(
                                  Icons.location_searching_rounded,
                                  "Track Driver",
                                  splashCyan,
                                ),
                              ),
                            ],
                          ),

                          gapH(12),

                          Row(
                            children: [
                              Expanded(
                                child: actionCard(
                                  Icons.history_rounded,
                                  "Trip History",
                                  grn,
                                ),
                              ),
                              gapW(12),
                              Expanded(
                                child: actionCard(
                                  Icons.settings_outlined,
                                  "Settings",
                                  blueGrey,
                                ),
                              ),
                            ],
                          ),

                          gapH(30),

                          // Recent Activity
                          customTxt(
                            "Recent Activity",
                            18,
                            navyBlue,
                            FontWeight.w700,
                          ),

                          gapH(15),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 28,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: blueGrey.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history_rounded,
                                  size: 38,
                                  color: blueGrey.withValues(alpha: 0.7),
                                ),
                                gapH(10),
                                customTxt(
                                  "No Recent Activity",
                                  14,
                                  navyBlue,
                                  FontWeight.w600,
                                ),
                                gapH(5),
                                customParaTxt(
                                  "Your recent driver activities will appear here.",
                                  11,
                                  blueGrey,
                                  FontWeight.w400,
                                  TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          gapH(20),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Navigation
                  bottomNavigation(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
