import 'package:flutter_test/flutter_test.dart';
import 'package:gas_station_finder/services/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_service_test.mocks.dart';

@GenerateMocks([GeoLocatorWrapper])
void main() {
  group('location_service_unit_tests', () {
    final geoLocatorMock = MockGeoLocatorWrapper();
    final locationService = LocationService(geoLocatorMock);
    const mockPosition = Position(
        longitude: 41.1,
        latitude: 12,
        timestamp: null,
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);
    test('Should throw when location service not enabled', () async {
      when(geoLocatorMock.isLocationServiceEnabled())
          .thenAnswer((_) async => false);

      expect(
        locationService.getCurrentPosition(),
        throwsA(equals('Please enable Your Location Service')),
      );
    });
    test('Should throw when permission denied', () async {
      when(geoLocatorMock.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(geoLocatorMock.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(geoLocatorMock.requestPermission())
          .thenAnswer((_) async => LocationPermission.deniedForever);

      expect(
        locationService.getCurrentPosition(),
        throwsA(equals('Location must be enabled please go to app settings')),
      );
    });
    test('Should get position if permission granted', () async {
      when(geoLocatorMock.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(geoLocatorMock.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(geoLocatorMock.requestPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(geoLocatorMock.getCurrentPosition(
              desiredAccuracy: anyNamed('desiredAccuracy'),
              forceAndroidLocationManager:
                  anyNamed('forceAndroidLocationManager'),
              timeLimit: anyNamed('timeLimit')))
          .thenAnswer((_) async => mockPosition);

      expect(await locationService.getCurrentPosition(), mockPosition);
    });
    test('Should call getLastKnowPosition if getCurrentPosition fails',
        () async {
      when(geoLocatorMock.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(geoLocatorMock.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(geoLocatorMock.requestPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(geoLocatorMock.getCurrentPosition(
              desiredAccuracy: anyNamed('desiredAccuracy'),
              forceAndroidLocationManager:
                  anyNamed('forceAndroidLocationManager'),
              timeLimit: anyNamed('timeLimit')))
          .thenAnswer((_) async => null);
      when(
        geoLocatorMock.getLastKnowPosition(
          forceAndroidLocationManager: anyNamed('forceAndroidLocationManager'),
        ),
      ).thenAnswer((_) async => mockPosition);
      await locationService.getCurrentPosition();
      verify(geoLocatorMock.getLastKnowPosition()).called(1);
    });
  });
}
