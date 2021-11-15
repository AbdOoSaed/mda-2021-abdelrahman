import 'package:gas_station_finder/utils/utils.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  final GeoLocatorWrapper geoLocator;

  LocationService(this.geoLocator);

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geoLocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Please enable Your Location Service');
    }

    permission = await geoLocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geoLocator.requestPermission();
      if ([LocationPermission.denied, LocationPermission.deniedForever]
          .contains(permission)) {
        return Future.error(
          'Location must be enabled please go to app settings',
        );
      }
    }
    late Position? position;
    permission = await geoLocator.checkPermission();

    if ([LocationPermission.whileInUse, LocationPermission.always]
        .contains(permission)) {
      final currentPosition =
          await tryDo(() async => await geoLocator.getCurrentPosition(
                timeLimit: const Duration(seconds: 5),
              ));

      position = currentPosition ?? (await geoLocator.getLastKnowPosition());
    }

    if (position == null) {
      return Future.error('Sorry cannot determine your location!');
    }

    return position;
  }

  Duration getDurationTakenFromMeter(num meter,
      {double kmsPerMin = 0.5 /*speed*/
      }) {
    //this is not real it is just an estimation

    final kms = meter / 1000;

    final minsTaken = kms / kmsPerMin;
    return Duration(minutes: minsTaken.toInt());
  }
}

// geoLocator package not testable, all functions static so i made wrapper class
class GeoLocatorWrapper {
  /// check if the Location Service is Enabled
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  /// Returns a [Future] indicating if the user allows the App to access the device's location.
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  /// Calculates the distance between the supplied coordinates in meters.
  double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) =>
      Geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );

  Future<bool> openAppSettings() => Geolocator.openAppSettings();

  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();

  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  /// returns the current position
  Future<Position?> getCurrentPosition({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    bool forceAndroidLocationManager = false,
    Duration? timeLimit,
  }) async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: desiredAccuracy,
      forceAndroidLocationManager: forceAndroidLocationManager,
      timeLimit: timeLimit,
    );
  }

  /// Returns the last known position stored on the users device.
  Future<Position?> getLastKnowPosition(
      {bool forceAndroidLocationManager = false}) async {
    return Geolocator.getLastKnownPosition(
      forceAndroidLocationManager: forceAndroidLocationManager,
    );
  }
}
