import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas_station_finder/data/models/models.dart';
import 'package:gas_station_finder/data/repositories/repositories.dart';

part 'station_list_event.dart';

part 'station_list_state.dart';

class StationListBloc extends Bloc<StationListEvent, StationListState> {
  StationListBloc({required this.repository})
      : super(const StationListState()) {
    on<GetGasStation>((event, emit) => _mapSearchEventToState(event, emit));
  }

  final GasStationRepository repository;

  void _mapSearchEventToState(
      StationListEvent event, Emitter<StationListState> emit) async {
    if (event is GetGasStation) {
      try {
        emit(state.copyWith(status: StationListStatus.loading));
        final model = await repository.getGasStation(event.lat, event.long);

        emit(state.copyWith(model: model, status: StationListStatus.success));
      } catch (error) {
        emit(state.copyWith(
          status: StationListStatus.failure,
          error: error.toString(),
        ));
      }
    }
  }
}
