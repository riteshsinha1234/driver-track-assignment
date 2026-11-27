import 'package:flutter_test/flutter_test.dart';
import 'package:driver_track/main.dart';

void main() {
  testWidgets('DriverTrack app launches successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(MyApp), findsOneWidget);
  });
}
