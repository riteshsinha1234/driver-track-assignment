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
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.gps_fixed_rounded,
                        color: splashCyan,
                        size: 17,
                      ),

                      gapW(8),

                      customTxt(
                        "SMART LOCATION TRACKING",
                        11,
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
                                  height: 175,
                                  width: 175,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: logoBackground,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: logoBorder),
                                    boxShadow: [
                                      BoxShadow(
                                        color: splashCyan.withValues(
                                          alpha: 0.12,
                                        ),
                                        blurRadius: 45,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    ImagePath.logoPng,
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                gapH(35),

                                // App Name
                                customTxt(
                                  "DriverTrack",
                                  34,
                                  white,
                                  FontWeight.w800,
                                  letterSpacing: 1,
                                ),

                                gapH(12),

                                // Tagline
                                customTxt(
                                  "TRACK SMART. DRIVE SAFE.",
                                  12,
                                  splashCyan,
                                  FontWeight.w700,
                                  letterSpacing: 2.5,
                                ),

                                gapH(12),

                                // Description
                                customParaTxt(
                                  "Smart Driver Location Tracking",
                                  13,
                                  splashText,
                                  FontWeight.w400,
                                  TextAlign.center,
                                  letterSpacing: 0.5,
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
                  padding: const EdgeInsets.only(
                    bottom: 35,
                    left: 30,
                    right: 30,
                  ),
                  child: BlocBuilder<SplashBloc, SplashState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          // Loading Indicator
                          const SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                splashCyan,
                              ),
                            ),
                          ),

                          gapH(20),

                          // Loading Text
                          customTxt(
                            state is SplashLoading
                                ? "INITIALIZING YOUR EXPERIENCE..."
                                : "GETTING READY...",
                            10,
                            loadingText,
                            FontWeight.w600,
                            letterSpacing: 1.5,
                          ),

                          gapH(25),

                          // Footer
                          customTxt(
                            "POWERED BY DRIVERTRACK",
                            9,
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
