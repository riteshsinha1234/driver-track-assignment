
abstract class BottomNavigationEvent {}

class ChangeNavigationTab extends BottomNavigationEvent {
  final int index;

  ChangeNavigationTab(this.index);
}
