import 'package:dio/dio.dart';
import 'package:gas_station_finder/data/network/apis/gas_station/gas_station_api.dart';
import 'package:gas_station_finder/data/network/dio_client.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/repositories.dart';

final sL = GetIt.instance;

Future<void> setupLocator() async {
  // singletons:----------------------------------------------------------------
  sL.registerSingleton(Dio());
  sL.registerSingleton(DioClient(sL<Dio>()));

  // api's:---------------------------------------------------------------------
  sL.registerSingleton(GasStationApi(sL<DioClient>()));

  // // repository:----------------------------------------------------------------
  sL.registerSingleton(GasStationRepository(sL<GasStationApi>()));
}
