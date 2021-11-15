import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_station_finder/screens/screens.dart';
import 'package:gas_station_finder/screens/station_list/bloc/station_list_bloc.dart';
import 'package:gas_station_finder/services/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/testable_widget.dart';
import 'station_list_test.mocks.dart';

class MockStationListBloc extends MockBloc<StationListEvent, StationListState>
    implements StationListBloc {}

class FakeStationListState extends Fake implements StationListState {}

class FakeStationListEvent extends Fake implements StationListEvent {}

@GenerateMocks([LocationService])
void main() {
  late MockStationListBloc bloc;

  setUpAll(() {
    // Register the event and the state
    registerFallbackValue(FakeStationListState());
    registerFallbackValue(FakeStationListEvent());
  });

  setUp(() {
    bloc = MockStationListBloc();
  });

  group('StationList WidgetTest ', () {
    final locationService = MockLocationService();
    const mockPosition = Position(
        longitude: 41.1,
        latitude: 12,
        timestamp: null,
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);
    testWidgets('render FailureView when state is [StationListStatus.failure]',
        (tester) async {
      when(() => bloc.state).thenReturn(
        const StationListState(status: StationListStatus.failure),
      );
      await tester.pumpWidget(testableWidget(
        child: BlocProvider<StationListBloc>(
          lazy: false,
          create: (_) => bloc,
          child: StationList(
            initialPosition: mockPosition,
            locationService: locationService,
          ),
        ),
      ));

      expect(find.byKey(const Key('StationListFailure')), findsOneWidget);
    });

    testWidgets('render LoadingView when state is [StationListStatus.loading]',
        (tester) async {
      when(() => bloc.state).thenReturn(
        const StationListState(status: StationListStatus.loading),
      );
      await tester.pumpWidget(testableWidget(
        child: BlocProvider<StationListBloc>(
          lazy: false,
          create: (_) => bloc,
          child: StationList(
            initialPosition: mockPosition,
            locationService: locationService,
          ),
        ),
      ));

      expect(find.byKey(const Key('StationListLoading')), findsOneWidget);
    });

    testWidgets('render SuccessView when state is [StationListStatus.success]',
        (tester) async {
      when(() => bloc.state).thenReturn(
        const StationListState(status: StationListStatus.success),
      );
      await tester.pumpWidget(testableWidget(
        child: BlocProvider<StationListBloc>(
          lazy: false,
          create: (_) => bloc,
          child: StationList(
            initialPosition: mockPosition,
            locationService: locationService,
          ),
        ),
      ));
      expect(find.byKey(const Key('StationListSuccess')), findsOneWidget);
    });
    testWidgets('should call GetGasStation when refresh btn clicked',
        (tester) async {
      when(() => bloc.state).thenReturn(
        const StationListState(status: StationListStatus.success),
      );
      await tester.pumpWidget(testableWidget(
        child: BlocProvider<StationListBloc>(
          lazy: false,
          create: (_) => bloc,
          child: StationList(
            initialPosition: mockPosition,
            locationService: locationService,
          ),
        ),
      ));
      expect(find.byType(IconButton), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verify(() => bloc.add(
            GetGasStation(mockPosition.latitude, mockPosition.longitude),
          )).called(2);
    });
  });
}
