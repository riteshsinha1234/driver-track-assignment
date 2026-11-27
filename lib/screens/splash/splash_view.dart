import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/image.dart';
import 'package:driver_track/components/routers.dart';
import 'package:driver_track/components/text.dart';
import 'package:driver_track/components/widget.dart';
import 'package:driver_track/screens/home/home_view.dart';
import 'package:driver_track/screens/splash/splash_bloc.dart';
import 'package:driver_track/screens/splash/splash_event.dart';
import 'package:driver_track/screens/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        final bloc = context.read<SplashBloc>();

        if (bloc.state is SplashInitial) {
          bloc.add(StartSplash());
        }
      }
    });

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          routePushReplacement(const HomeView());
        }
      },
      child: customBody(
        backgroundColor: splashBackground,
        child: Container(
          width: screenWidth(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [splashBackground, splashGradient, splashBackground],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Branding
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.gps_fixed_rounded,
                        color: splashCyan,
                        size: 5.w,
                      ),
                      gapW(2.w),
                      customTxt(
                        "SMART LOCATION TRACKING",
                        12,
                        splashText,
                        FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ],
                  ),
                ),

                // Center Branding
                Expanded(
                  child: Center(
                    child: BlocBuilder<SplashBloc, SplashState>(
                      builder: (context, state) {
                        return AnimatedOpacity(
                          opacity: state is SplashInitial ? 0.5 : 1.0,
                          duration: const Duration(milliseconds: 800),
                          child: AnimatedScale(
                            scale: state is SplashInitial ? 0.85 : 1.0,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeOutBack,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Logo Container
                                Container(
                                  height: 45.w,
                                  width: 45.w,
                                  padding: EdgeInsets.all(2.5.w),
                                  decoration: BoxDecoration(
                                    color: logoBackground,
                                    borderRadius: BorderRadius.circular(50.w),
                                    border: Border.all(
                                      color: logoBorder,
                                      width: 0.2.w,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: splashCyan.withValues(
                                          alpha: 0.12,
                                        ),
                                        blurRadius: 11.w,
                                        spreadRadius: 1.3.w,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    ImagePath.logoPng,
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                gapH(4.w),

                                // App Name
                                customTxt(
                                  "DriverTrack",
                                  24,
                                  white,
                                  FontWeight.w800,
                                  letterSpacing: 1,
                                ),

                                gapH(2.5.w),

                                // Tagline
                                customTxt(
                                  "TRACK SMART. DRIVE SAFE.",
                                  14,
                                  splashCyan,
                                  FontWeight.w700,
                                  letterSpacing: 2.5,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Bottom Loading Section
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h, left: 7.w, right: 7.w),
                  child: BlocBuilder<SplashBloc, SplashState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          // Loading Indicator
                          SizedBox(
                            height: 7.w,
                            width: 7.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                splashCyan,
                              ),
                            ),
                          ),

                          gapH(5.w),

                          // Loading Text
                          customTxt(
                            state is SplashLoading
                                ? "INITIALIZING YOUR EXPERIENCE..."
                                : "GETTING READY...",
                            12,
                            loadingText,
                            FontWeight.w600,
                            letterSpacing: 1.5,
                          ),

                          gapH(2.w),

                          // Footer
                          customTxt(
                            "POWERED BY DRIVERTRACK",
                            14,
                            footerText,
                            FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
