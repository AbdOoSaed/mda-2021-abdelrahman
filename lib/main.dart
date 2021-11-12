import 'package:flutter/material.dart';
import 'package:gas_station_finder/location_service.dart';
import 'package:geolocator/geolocator.dart';

import 'location_access.dart';
import 'station_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          '/': (context) => LocationAccess(
                locationService: LocationService(),
                onSuccess: (Position currentPosition) {
                  Navigator.pushNamed(
                    context,
                    '/station_list',
                    arguments: currentPosition,
                  );
                },
              ),
          '/station_list': (context) => StationList(
                initialPosition: settings.arguments as Position,
                locationService: LocationService(),
              ),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
      },
    );
  }
}
