import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_station_finder/screens/screens.dart';
import 'package:gas_station_finder/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/testable_widget.dart';
import 'location_access_test.mocks.dart';

@GenerateMocks([LocationService])
void main() {
  const mockPosition = Position(
      longitude: 41.1,
      latitude: 12,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  testWidgets('Should return location if successful',
      (WidgetTester tester) async {
    final locationService = MockLocationService();
    when(locationService.getCurrentPosition())
        .thenAnswer((_) async => mockPosition);
    Position? position;
    await tester.pumpWidget(testableWidget(
      child: LocationAccess(
        locationService: locationService,
        onSuccess: (Position pos) {
          position = pos;
        },
      ),
    ));
    await tester.tap(find.byKey(const Key('locationAccessBtn')));
    expect(position, mockPosition);
  });
  testWidgets('Should return null if not successful',
      (WidgetTester tester) async {
    final locationService = MockLocationService();
    when(locationService.getCurrentPosition())
        .thenAnswer((_) async => throw Null);
    Position? position;
    await tester.pumpWidget(testableWidget(
      child: LocationAccess(
        locationService: locationService,
        onSuccess: (Position pos) {
          position = pos;
        },
      ),
    ));
    await tester.tap(find.byKey(const Key('locationAccessBtn')));
    expect(position, null);
  });
}
