import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../components/colors.dart';
import '../../components/widget.dart';
import '../home/home_view.dart';
import '../tracking/tracking_view.dart';
import 'bottom_navigation_bloc.dart';
import 'bottom_navigation_event.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: splashBackground,
          body: IndexedStack(
            index: state.selectedIndex,
            children: const [HomeView(), TrackingView()],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 2.5.w),
            decoration: BoxDecoration(
              color: logoBackground,
              border: Border(top: BorderSide(color: logoBorder)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(
                  context,
                  icon: Icons.home_rounded,
                  title: 'Home',
                  index: 0,
                  selectedIndex: state.selectedIndex,
                ),
                _navItem(
                  context,
                  icon: Icons.location_on_outlined,
                  title: 'Tracking',
                  index: 1,
                  selectedIndex: state.selectedIndex,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _navItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int index,
    required int selectedIndex,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        context.read<BottomNavigationBloc>().add(ChangeNavigationTab(index));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 5.w : 4.w,
          vertical: 1.5.w,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? splashCyan.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? splashCyan.withValues(alpha: 0.35)
                : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              child: Icon(
                icon,
                size: 6.w,
                color: isSelected ? splashCyan : loadingText,
              ),
            ),
            gapH(1.2.w),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 14.sp,
                color: isSelected ? splashCyan : splashText,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              child: Text(title),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              margin: EdgeInsets.only(top: 1.w),
              height: 0.6.w,
              width: isSelected ? 5.w : 0,
              decoration: BoxDecoration(
                color: splashCyan,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
