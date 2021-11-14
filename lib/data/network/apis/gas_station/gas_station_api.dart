import 'dart:async';

import 'package:gas_station_finder/data/models/models.dart';
import 'package:gas_station_finder/data/network/constants/endpoints.dart';
import 'package:gas_station_finder/data/network/dio_client.dart';

class GasStationApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  GasStationApi(this._dioClient);

  /// Returns list of post in response
  Future<PetrolStationResModel> getGasStation(num lat, num long) async {
    try {
      final res = await _dioClient.get(Endpoints.getGasStation(lat, long));
      return PetrolStationResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
