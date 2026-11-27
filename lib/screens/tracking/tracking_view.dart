import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../components/colors.dart';
import '../../components/text.dart';
import '../../components/widget.dart';
import 'tracking_bloc.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingView extends StatelessWidget {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TrackingBloc(locationRepository: context.read())
            ..add(LoadTrackingRecords()),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Column(
              children: [
                // Static Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTxt(
                            "DriverTrack",
                            14,
                            splashText,
                            FontWeight.w500,
                          ),
                          gapH(1.3.w),
                          customTxt(
                            "Tracking History",
                            20,
                            white,
                            FontWeight.w800,
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(2.5.w),
                        decoration: BoxDecoration(
                          color: logoBackground,
                          shape: BoxShape.circle,
                          border: Border.all(color: logoBorder),
                        ),
                        child: Icon(
                          Icons.location_history_rounded,
                          color: splashCyan,
                          size: 5.5.w,
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable Tracking Records
                Expanded(
                  child: BlocBuilder<TrackingBloc, TrackingState>(
                    builder: (context, state) {
                      if (state is TrackingLoading ||
                          state is TrackingInitial) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: splashBackground,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: splashCyan,
                              strokeWidth: 3.5,
                            ),
                          ),
                        );
                      }

                      if (state is TrackingError) {
                        return Center(
                          child: customTxt(
                            "Error: ${state.error}",
                            13,
                            red,
                            FontWeight.w600,
                          ),
                        );
                      }

                      if (state is TrackingLoaded) {
                        return RefreshIndicator(
                          color: splashCyan,
                          backgroundColor: logoBackground,
                          onRefresh: () async {
                            context.read<TrackingBloc>().add(
                              RefreshTrackingRecords(),
                            );

                            await Future<void>.delayed(
                              const Duration(milliseconds: 300),
                            );
                          },
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 2.w,
                            ),
                            children: [
                              // Recent Activity
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customTxt(
                                    "Recent Activity",
                                    18,
                                    white,
                                    FontWeight.w700,
                                  ),
                                  customTxt(
                                    "${state.totalRecords} Records",
                                    13,
                                    splashCyan,
                                    FontWeight.w700,
                                  ),
                                ],
                              ),

                              gapH(3.w),

                              // Empty State
                              if (state.locations.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 7.w,
                                    horizontal: 4.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: logoBackground,
                                    borderRadius: BorderRadius.circular(4.5.w),
                                    border: Border.all(color: logoBorder),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.history_rounded,
                                        size: 11.w,
                                        color: loadingText,
                                      ),
                                      gapH(2.5.w),
                                      customTxt(
                                        "No Tracking Records",
                                        15,
                                        white,
                                        FontWeight.w600,
                                      ),
                                      gapH(1.3.w),
                                      customParaTxt(
                                        "Start location tracking to see your recorded locations here.",
                                        12,
                                        splashText,
                                        FontWeight.w400,
                                        TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              else
                                ...state.locations.map((record) {
                                  final localTime = record.timestamp.toLocal();

                                  final date =
                                      "${localTime.year.toString().padLeft(4, '0')}-"
                                      "${localTime.month.toString().padLeft(2, '0')}-"
                                      "${localTime.day.toString().padLeft(2, '0')}";

                                  final time =
                                      "${localTime.hour.toString().padLeft(2, '0')}:"
                                      "${localTime.minute.toString().padLeft(2, '0')}:"
                                      "${localTime.second.toString().padLeft(2, '0')}";

                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: 2.5.w),
                                    padding: EdgeInsets.all(3.5.w),
                                    decoration: BoxDecoration(
                                      color: logoBackground,
                                      borderRadius: BorderRadius.circular(4.w),
                                      border: Border.all(color: logoBorder),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Location Icon
                                        Container(
                                          padding: EdgeInsets.all(3.w),
                                          decoration: BoxDecoration(
                                            color: splashCyan.withValues(
                                              alpha: 0.12,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              3.w,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.location_on_rounded,
                                            color: splashCyan,
                                          ),
                                        ),

                                        gapW(3.w),

                                        // Location Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customTxt(
                                                record.locationName,
                                                16,
                                                white,
                                                FontWeight.w700,
                                              ),
                                              gapH(1.5.w),
                                              customTxt(
                                                "Latitude: ${record.latitude.toStringAsFixed(5)}",
                                                14,
                                                splashText,
                                                FontWeight.w700,
                                              ),
                                              gapH(0.8.w),
                                              customTxt(
                                                "Longitude: ${record.longitude.toStringAsFixed(5)}",
                                                14,
                                                splashText,
                                                FontWeight.w700,
                                              ),
                                              gapH(1.5.w),
                                              customTxt(
                                                "Date: $date",
                                                12,
                                                loadingText,
                                                FontWeight.w600,
                                              ),
                                              gapH(0.8.w),
                                              customTxt(
                                                "Time: $time",
                                                12,
                                                loadingText,
                                                FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),

                                        gapW(1.w),

                                        // Sync Status
                                        Column(
                                          children: [
                                            Icon(
                                              record.isSynced
                                                  ? Icons.cloud_done_rounded
                                                  : Icons.cloud_upload_outlined,
                                              color: record.isSynced
                                                  ? grn
                                                  : orang,
                                              size: 5.w,
                                            ),
                                            gapH(1.w),
                                            customTxt(
                                              record.isSynced
                                                  ? "Synced"
                                                  : "Pending",
                                              12,
                                              record.isSynced ? grn : orang,
                                              FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            ],
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
