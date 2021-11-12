import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';

typedef SuccessLocationCallback = void Function(Position);

class LocationAccess extends StatelessWidget {
  final LocationService locationService;
  final SuccessLocationCallback onSuccess;
  const LocationAccess(
      {Key? key, required this.locationService, required this.onSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Todo implement');
  }
}
