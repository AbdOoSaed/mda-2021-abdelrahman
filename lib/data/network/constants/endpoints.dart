import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  Endpoints._();

  static String getGasStation(num lat, num long, {num radius = 9000}) {
    //ge GasStation within a radius of 9000 meters of his location.
    return 'https://places.ls.hereapi.com/places/v1/discover/explore?apiKey=${dotenv.get('HERE_API_KEY')}&in=$lat,$long;r=$radius&cat=petrol-station&pretty';
  }
}
