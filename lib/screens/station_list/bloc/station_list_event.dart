part of 'station_list_bloc.dart';

class StationListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGasStation extends StationListEvent {
  final num lat;
  final num long;

  GetGasStation(this.lat, this.long);

  @override
  List<Object?> get props => [lat, long];
}
