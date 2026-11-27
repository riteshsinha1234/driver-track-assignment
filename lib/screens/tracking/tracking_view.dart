import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../components/colors.dart';
import '../../components/routers.dart';
import '../../components/text.dart';
import '../../components/widget.dart';
import 'tracking_bloc.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingView extends StatelessWidget {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return customBody(
      backgroundColor: iceWhite,
      child: BlocProvider(
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 5.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customTxt(
                              "DriverTrack",
                              14,
                              blueGrey,
                              FontWeight.w500,
                            ),
                            gapH(1.3.w),
                            customTxt(
                              "Tracking History",
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
                            Icons.location_history_rounded,
                            color: electricBlue,
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
                          return const Center(
                            child: CircularProgressIndicator(
                              color: electricBlue,
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
                            color: electricBlue,
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
                                      navyBlue,
                                      FontWeight.w700,
                                    ),
                                    customTxt(
                                      "${state.totalRecords} Records",
                                      13,
                                      electricBlue,
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
                                      color: white,
                                      borderRadius: BorderRadius.circular(
                                        4.5.w,
                                      ),
                                      border: Border.all(
                                        color: blueGrey.withValues(alpha: 0.15),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.history_rounded,
                                          size: 11.w,
                                          color: blueGrey.withValues(
                                            alpha: 0.7,
                                          ),
                                        ),
                                        gapH(2.5.w),
                                        customTxt(
                                          "No Tracking Records",
                                          15,
                                          navyBlue,
                                          FontWeight.w600,
                                        ),
                                        gapH(1.3.w),
                                        customParaTxt(
                                          "Start location tracking to see your recorded locations here.",
                                          12,
                                          blueGrey,
                                          FontWeight.w400,
                                          TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  ...state.locations.map((record) {
                                    return Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 2.5.w),
                                      padding: EdgeInsets.all(3.5.w),
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(
                                          4.w,
                                        ),
                                        border: Border.all(
                                          color: blueGrey.withValues(
                                            alpha: 0.15,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(3.w),
                                            decoration: BoxDecoration(
                                              color: electricBlue.withValues(
                                                alpha: 0.1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(3.w),
                                            ),
                                            child: const Icon(
                                              Icons.location_on_rounded,
                                              color: electricBlue,
                                            ),
                                          ),
                                          gapW(3.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                customTxt(
                                                  "Location Record",
                                                  14,
                                                  navyBlue,
                                                  FontWeight.w700,
                                                ),
                                                gapH(1.w),
                                                customTxt(
                                                  "${record.latitude.toStringAsFixed(5)}, ${record.longitude.toStringAsFixed(5)}",
                                                  13,
                                                  blueGrey,
                                                  FontWeight.w500,
                                                ),
                                                gapH(1.w),
                                                customTxt(
                                                  record.timestamp
                                                      .toLocal()
                                                      .toString()
                                                      .substring(0, 19),
                                                  11,
                                                  blueGrey,
                                                  FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),
                                          gapW(1.w),
                                          Column(
                                            children: [
                                              Icon(
                                                record.isSynced
                                                    ? Icons.cloud_done_rounded
                                                    : Icons
                                                          .cloud_upload_outlined,
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
                                                11,
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

                  // Shared Bottom Navigation
                  bottomNavigationBar(
                    context,
                    selectedIndex: 1,
                    onHomeTap: kNavigationPop,
                    onTrackingTap: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
