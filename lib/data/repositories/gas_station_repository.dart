import 'dart:async';

import 'package:gas_station_finder/data/models/models.dart';
import 'package:gas_station_finder/data/network/apis/gas_station/gas_station_api.dart';

class GasStationRepository {
  final GasStationApi _api;

  GasStationRepository(this._api);

  Future<PetrolStationResModel> getGasStation(num lat, num long) async {
    return await _api.getGasStation(lat, long);
  }
}
