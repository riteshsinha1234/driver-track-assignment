import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/text.dart';
import 'package:driver_track/components/widget.dart';
import 'package:driver_track/components/routers.dart';
import 'package:driver_track/screens/home/home_bloc.dart';
import 'package:driver_track/screens/home/home_event.dart';
import 'package:driver_track/screens/home/home_state.dart';
import 'package:driver_track/screens/tracking/tracking_view.dart';
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
                12,
                red,
                FontWeight.w600,
              ),
            );
          }

          if (state is HomeLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  // Static Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 4.w,
                    ),
                    child: Row(
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
                              20,
                              navyBlue,
                              FontWeight.w800,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(2.5.w),
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: blueGrey.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Icon(
                            Icons.local_shipping_outlined,
                            color: electricBlue,
                            size: 5.5.w,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Start from Tracking Overview here
                          gapH(5.w),

                          // Tracking Overview
                          Container(
                            width: screenWidth(context),
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
                                  blurRadius: 4.w,
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
                                      height: 2.w,
                                      width: 2.w,
                                      decoration: BoxDecoration(
                                        color: state.isTracking ? grn : orang,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    gapW(2.w),
                                    customTxt(
                                      "TRACKING OVERVIEW",
                                      12,
                                      splashText,
                                      FontWeight.w600,
                                      letterSpacing: 1.5,
                                    ),
                                    const Spacer(),
                                    customTxt(
                                      state.isTracking ? "LIVE" : "STOPPED",
                                      12,
                                      state.isTracking ? grn : orang,
                                      FontWeight.w700,
                                    ),
                                  ],
                                ),
                                gapH(5.w),
                                customTxt(
                                  "Your Drivers,",
                                  20,
                                  white,
                                  FontWeight.w700,
                                ),
                                gapH(1.2.w),
                                Row(
                                  children: [
                                    Expanded(
                                      child: overviewItem(
                                        Icons.location_on_outlined,
                                        "Total Locations",
                                        "${state.totalLocations}",
                                      ),
                                    ),
                                    Container(
                                      height: 12.w,
                                      width: 0.25.w,
                                      color: white.withValues(alpha: 0.15),
                                    ),
                                    gapW(1.5.w),
                                    Expanded(
                                      child: overviewItem(
                                        Icons.track_changes_outlined,
                                        "Active Tracking",
                                        state.isTracking ? "1" : "0",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          gapH(4.w),

                          // Connectivity Status
                          Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.5.w,
                              vertical: 4.w,
                            ),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(4.w),
                              border: Border.all(
                                color: blueGrey.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  state.isConnected
                                      ? Icons.wifi_rounded
                                      : Icons.wifi_off_rounded,
                                  color: state.isConnected ? grn : orang,
                                  size: 6.w,
                                ),
                                gapW(2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customTxt(
                                        state.isConnected
                                            ? "Internet Connected"
                                            : "You are Offline",
                                        16,
                                        navyBlue,
                                        FontWeight.w700,
                                      ),
                                      gapH(1.w),
                                      customTxt(
                                        state.isConnected
                                            ? "Ready to synchronize records"
                                            : "Locations are saved locally",
                                        12.5,
                                        blueGrey,
                                        FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  state.isConnected
                                      ? Icons.check_circle
                                      : Icons.cloud_off_outlined,
                                  color: state.isConnected ? grn : orang,
                                  size: 4.5.w,
                                ),
                              ],
                            ),
                          ),

                          gapH(5.h),

                          // Location Tracking
                          customTxt(
                            "Location Tracking",
                            18,
                            navyBlue,
                            FontWeight.w700,
                          ),

                          gapH(2.h),

                          Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(4.5.w),
                              border: Border.all(
                                color: blueGrey.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.my_location_rounded,
                                      color: electricBlue,
                                      size: 6.w,
                                    ),
                                    gapW(2.w),
                                    Expanded(
                                      child: customTxt(
                                        state.isTracking
                                            ? "Location tracking is active"
                                            : "Location tracking is stopped",
                                        14,
                                        navyBlue,
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                gapH(2.h),

                                // Start / Stop Button
                                customButton(
                                  40.0,
                                  screenWidth(context) / 2,
                                  state.isTracking ? red : electricBlue,
                                  state.isTracking ? red : electricBlue,
                                  8.0,
                                  () {
                                    context.read<HomeBloc>().add(
                                      state.isTracking
                                          ? StopTracking()
                                          : StartTracking(),
                                    );
                                  },
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        state.isTracking
                                            ? Icons.stop_rounded
                                            : Icons.play_arrow_rounded,
                                        color: white,
                                      ),
                                      gapW(1.w),
                                      customTxt(
                                        state.isTracking
                                            ? "Stop Tracking"
                                            : "Start Tracking",
                                        14,
                                        white,
                                        FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          gapH(5.h),

                          // Quick Overview
                          customTxt(
                            "Quick Overview",
                            18,
                            navyBlue,
                            FontWeight.w700,
                          ),

                          gapH(2.h),

                          Row(
                            children: [
                              Expanded(
                                child: statCard(
                                  Icons.location_on_outlined,
                                  "Total Records",
                                  "${state.totalLocations}",
                                  electricBlue,
                                ),
                              ),
                              gapW(2.w),
                              Expanded(
                                child: statCard(
                                  Icons.cloud_done_outlined,
                                  "Synchronized",
                                  "${state.syncedLocations}",
                                  grn,
                                ),
                              ),
                            ],
                          ),

                          gapH(2.h),

                          Row(
                            children: [
                              Expanded(
                                child: statCard(
                                  Icons.pending_actions_outlined,
                                  "Pending",
                                  "${state.pendingLocations}",
                                  orang,
                                ),
                              ),
                              gapW(3.w),
                              Expanded(
                                child: statCard(
                                  Icons.refresh_rounded,
                                  "Retry Attempts",
                                  "${state.locations.fold<int>(0, (sum, record) => sum + record.retryCount)}",
                                  splashCyan,
                                ),
                              ),
                            ],
                          ),

                          gapH(4.w),

                          // Data Synchronization
                          Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(4.5.w),
                              border: Border.all(
                                color: blueGrey.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                    color: electricBlue.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Icon(
                                    Icons.sync_rounded,
                                    color: electricBlue,
                                    size: 6.w,
                                  ),
                                ),
                                gapW(3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customTxt(
                                        "Data Sync",
                                        16,
                                        navyBlue,
                                        FontWeight.w700,
                                      ),
                                      gapH(1.w),
                                      customTxt(
                                        "${state.pendingLocations} records waiting to sync",
                                        14,
                                        blueGrey,
                                        FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      state.isConnected &&
                                          state.pendingLocations > 0
                                      ? () {
                                          context.read<HomeBloc>().add(
                                            SyncLocations(),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.sync),
                                  color: electricBlue,
                                  disabledColor: blueGrey,
                                ),
                              ],
                            ),
                          ),

                          gapH(5.w),
                        ],
                      ),
                    ),
                  ),

                  // Shared Bottom Navigation from widget.dart
                  bottomNavigationBar(
                    context,
                    selectedIndex: 0,
                    onHomeTap: () {},
                    onTrackingTap: () => routePush(const TrackingView()),
                  ),
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
