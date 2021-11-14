import 'dart:convert';

import 'package:gas_station_finder/services/services.dart';

class PetrolStationResModel {
  PetrolStationResModel({
    required this.results,
    required this.search,
  });

  final Results results;
  final Search search;

  factory PetrolStationResModel.fromRawJson(String str) =>
      PetrolStationResModel.fromJson(json.decode(str));

  factory PetrolStationResModel.fromJson(Map<String, dynamic> json) =>
      PetrolStationResModel(
        results: Results.fromJson(json["results"]),
        search: Search.fromJson(json["search"]),
      );
}

class Results {
  Results({required this.items});

  final List<Item> items;

  factory Results.fromRawJson(String str) => Results.fromJson(json.decode(str));

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    required this.position,
    required this.distance,
    required this.title,
    required this.averageRating,
    required this.vicinity,
  });

  final List<double> position;
  final num distance;
  final String title;
  final num averageRating;
  final String vicinity;
  String get cleanedVicinity => vicinity.replaceAll('<br/>', ', ');
  String getETA(LocationService locationService) {
    final duration = locationService.getDurationTakenFromMeter(distance);
    final d = duration.toString().split(':'); //[hours, min, sec]
    final hours = d[0];
    final mins = d[1];
    return '${hours}h ${mins}m';
  }

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
        distance: json["distance"],
        title: json["title"],
        averageRating: json["averageRating"],
        vicinity: json["vicinity"],
      );
}

class Search {
  Search({required this.context});

  final Context context;

  factory Search.fromRawJson(String str) => Search.fromJson(json.decode(str));

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        context: Context.fromJson(json["context"]),
      );
}

class Context {
  Context({
    required this.location,
    required this.type,
    required this.href,
  });

  final Location location;
  final String type;
  final String href;

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        location: Location.fromJson(json["location"]),
        type: json["type"],
        href: json["href"],
      );
}

class Location {
  Location({
    required this.position,
    required this.address,
  });

  final List<double> position;
  final Address address;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
        address: Address.fromJson(json["address"]),
      );
}

class Address {
  Address({
    required this.text,
    required this.house,
    required this.street,
    required this.postalCode,
    required this.district,
    required this.city,
    required this.county,
    required this.country,
    required this.countryCode,
  });

  final String text;
  final String house;
  final String street;
  final String postalCode;
  final String district;
  final String city;
  final String county;
  final String country;
  final String countryCode;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        text: json["text"] ?? '',
        house: json["house"] ?? '',
        street: json["street"] ?? '',
        postalCode: json["postalCode"] ?? '',
        district: json["district"] ?? '',
        city: json["city"] ?? '',
        county: json["county"] ?? '',
        country: json["country"] ?? '',
        countryCode: json["countryCode"] ?? '',
      );
}
