import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'location_service.dart';

class StationList extends StatefulWidget {
  final Position initialPosition;
  final LocationService locationService;
  const StationList(
      {required this.initialPosition, required this.locationService, Key? key})
      : super(key: key);
  @override
  _StationListState createState() => _StationListState();
}

class _StationListState extends State<StationList> {
  late Position _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initialPosition;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        'TODO: implement searching for gas stations near $_currentPosition');
  }
}
