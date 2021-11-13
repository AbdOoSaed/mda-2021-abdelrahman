import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_station_finder/screens/screens.dart';
import 'package:gas_station_finder/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
    await tester.pumpWidget(MaterialApp(
        home: LocationAccess(
      locationService: locationService,
      onSuccess: (Position pos) {
        position = pos;
      },
    )));
    //tap Give permisson btn
    // TODO: Implement test.
    expect(position, null);
  });
}
