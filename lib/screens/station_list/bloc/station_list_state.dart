part of 'station_list_bloc.dart';

enum StationListStatus { loading, success, failure }

extension RandomCatStatusX on StationListStatus {
  bool get isLoading => this == StationListStatus.loading;

  bool get isSuccess => this == StationListStatus.success;

  bool get isFailure => this == StationListStatus.failure;
}

class StationListState extends Equatable {
  const StationListState({
    this.status = StationListStatus.loading,
    this.model,
    this.error = '',
  });

  final PetrolStationResModel? model;
  final StationListStatus status;
  final String? error;

  @override
  List<Object?> get props => [model, status];

  StationListState copyWith({
    PetrolStationResModel? model,
    StationListStatus? status,
    String? error,
  }) {
    return StationListState(
      model: model ?? this.model,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
