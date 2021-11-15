import 'package:flutter_test/flutter_test.dart';
import 'package:gas_station_finder/screens/station_list/bloc/station_list_bloc.dart';

void main() {
  group('StationListStatusX ', () {
    test('returns correct values for StationListStatus.loading', () {
      const status = StationListStatus.loading;
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for StationListStatus.isSuccess', () {
      const status = StationListStatus.success;

      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for StationListStatus.isFailure', () {
      const status = StationListStatus.failure;
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });
  });
}
