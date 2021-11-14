import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gas_station_finder/app.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(const MainApp());
}
