import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_station_finder/data/models/models.dart';
import 'package:gas_station_finder/data/repositories/repositories.dart';
import 'package:gas_station_finder/screens/station_list/bloc/station_list_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements GasStationRepository {}

class MockPetrolStationResModel extends Mock implements PetrolStationResModel {}

void main() {
  group('StationListBloc', () {
    late GasStationRepository gasStationRepository;
    late MockPetrolStationResModel mockPetrolStationResModel;

    setUp(() {
      gasStationRepository = MockRepository();
      mockPetrolStationResModel = MockPetrolStationResModel();
    });

    test('initial state of the bloc is [StationListStatus.loading]', () {
      expect(StationListBloc(repository: gasStationRepository).state.status,
          StationListStatus.loading);
    });

    blocTest<StationListBloc, StationListState>(
      'should emits [Station ListStatus.success] when successful',
      setUp: () {
        when(() => gasStationRepository.getGasStation(0, 0))
            .thenAnswer((_) async => mockPetrolStationResModel);
      },
      build: () => StationListBloc(repository: gasStationRepository),
      act: (bloc) => bloc.add(GetGasStation(0, 0)),
      expect: () => <StationListState>[
        const StationListState(status: StationListStatus.loading),
        StationListState(
            model: mockPetrolStationResModel,
            status: StationListStatus.success),
      ],
    );
  });
}
