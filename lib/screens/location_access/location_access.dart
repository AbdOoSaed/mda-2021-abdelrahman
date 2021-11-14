import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gas_station_finder/extensions/extensions.dart';
import 'package:gas_station_finder/services/services.dart';
import 'package:gas_station_finder/utils/utils.dart';
import 'package:geolocator/geolocator.dart';

typedef SuccessLocationCallback = void Function(Position);

class LocationAccess extends StatefulWidget {
  final LocationService locationService;
  final SuccessLocationCallback onSuccess;

  const LocationAccess({
    Key? key,
    required this.locationService,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<LocationAccess> createState() => _LocationAccessState();
}

class _LocationAccessState extends State<LocationAccess> {
  @override
  void initState() {
    //TODO(Abdelrahman): we can get location directly when screen open
    // _getLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    try {
      final currentPosition = await widget.locationService.getCurrentPosition();
      widget.onSuccess(currentPosition);
    } catch (e) {
      showToast(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Gas Station Finder',
            style: TextStyle(fontSize: 18.sp),
          ),
          SizedBox(height: 24.h),
          Text(
            'We need access to your location so we can provide the stations nearest to you.',
            style: TextStyle(fontSize: 14.sp, color: const Color(0xff69665C)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.h),
          OutlinedButton(
            key: const Key('locationAccessBtn'),
            onPressed: () => _getLocation(),
            child: const Text('Give permission'),
          )
        ],
      ).addPaddingHorizontalVertical(horizontal: 22).setCenter(),
    );
  }
}
