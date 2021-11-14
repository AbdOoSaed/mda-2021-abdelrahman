import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gas_station_finder/extensions/extensions.dart';
import 'package:gas_station_finder/screens/screens.dart';
import 'package:gas_station_finder/services/services.dart';
import 'package:geolocator/geolocator.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(
          constraints,
          designSize: const Size(411, 744), //width and height from figma
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color(0xffF8BA07),
            // accentColor: AppColor.accentColor,
            // colorScheme: ColorScheme.fromSwatch(
            //   primarySwatch: AppColor.primaryColor.toMaterialColor(),
            //   primaryColorDark: AppColor.primaryColor.toMaterialColor(),
            //   accentColor: AppColor.primaryColor.toMaterialColor(),
            // ),

            appBarTheme: AppBarTheme(
              centerTitle: true,
              textTheme: ThemeData.light().textTheme,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    const Color(0xffF8BA07).toMaterialStateProperty(),
                foregroundColor: Colors.black.toMaterialStateProperty(),
              ),
            ),
            buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          onGenerateRoute: (RouteSettings settings) {
            var routes = <String, WidgetBuilder>{
              '/': (context) => LocationAccess(
                    locationService: LocationService(GeoLocatorWrapper()),
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
                    locationService: LocationService(GeoLocatorWrapper()),
                  ),
            };
            WidgetBuilder builder = routes[settings.name]!;
            return MaterialPageRoute(builder: (context) => builder(context));
          },
        );
      },
    );
  }
}
