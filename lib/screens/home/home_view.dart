
import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/text.dart';
import 'package:driver_track/components/widget.dart';
import 'package:driver_track/screens/home/home_bloc.dart';
import 'package:driver_track/screens/home/home_event.dart';
import 'package:driver_track/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        final bloc = context.read<HomeBloc>();

        if (bloc.state is HomeInitial) {
          bloc.add(LoadHomeData());
        }
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 5.w,
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
                                  gapH(1.3.w),
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

                          gapH(5.w),

                          // Tracking Status
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [navyBlue, darkBlue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(5.5.w),
                              boxShadow: [
                                BoxShadow(
                                  color: navyBlue.withValues(alpha: 0.15),
                                  blurRadius: 4.5.w,
                                  offset: Offset(0, 2.w),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 2.3.w,
                                      width: 2.3.w,
                                      decoration: const BoxDecoration(
                                        color: cyan,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    gapW(2.w),
                                    customTxt(
                                      "TRACKING OVERVIEW",
                                      11,
                                      splashText,
                                      FontWeight.w600,
                                      letterSpacing: 1.5,
                                    ),
                                  ],
                                ),

                                gapH(5.w),

                                customTxt(
                                  "Your Drivers,",
                                  23,
                                  white,
                                  FontWeight.w700,
                                ),

                                gapH(1.3.w),

                                customTxt(
                                  "Your Business, Under Control.",
                                  13,
                                  blueGrey,
                                  FontWeight.w400,
                                ),

                                gapH(6.w),

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
                                      height: 12.w,
                                      width: 0.25.w,
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

                          gapH(5.w),

                          // Section heading
                          customTxt(
                            "Quick Overview",
                            18,
                            navyBlue,
                            FontWeight.w700,
                          ),

                          gapH(3.8.w),

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
                              gapW(3.w),
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

                          gapH(3.w),

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
                              gapW(3.w),
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

                          gapH(5.w),

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

                          gapH(3.8.w),

                          Row(
                            children: [
                              Expanded(
                                child: actionCard(
                                  Icons.person_add_alt_1_rounded,
                                  "Add Driver",
                                  electricBlue,
                                ),
                              ),
                              gapW(3.w),
                              Expanded(
                                child: actionCard(
                                  Icons.location_searching_rounded,
                                  "Track Driver",
                                  splashCyan,
                                ),
                              ),
                            ],
                          ),

                          gapH(3.w),

                          Row(
                            children: [
                              Expanded(
                                child: actionCard(
                                  Icons.history_rounded,
                                  "Trip History",
                                  grn,
                                ),
                              ),
                              gapW(3.w),
                              Expanded(
                                child: actionCard(
                                  Icons.settings_outlined,
                                  "Settings",
                                  blueGrey,
                                ),
                              ),
                            ],
                          ),

                          gapH(7.5.w),

                          // Recent Activity
                          customTxt(
                            "Recent Activity",
                            18,
                            navyBlue,
                            FontWeight.w700,
                          ),

                          gapH(3.8.w),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 7.w,
                              horizontal: 3.8.w,
                            ),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(4.5.w),
                              border: Border.all(
                                color: blueGrey.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history_rounded,
                                  size: 10.w,
                                  color: blueGrey.withValues(alpha: 0.7),
                                ),
                                gapH(2.5.w),
                                customTxt(
                                  "No Recent Activity",
                                  14,
                                  navyBlue,
                                  FontWeight.w600,
                                ),
                                gapH(1.3.w),
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

                          gapH(5.w),
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
