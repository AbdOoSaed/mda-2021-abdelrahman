import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas_station_finder/extensions/extensions.dart';
import 'package:gas_station_finder/screens/station_list/bloc/station_list_bloc.dart';
import 'package:gas_station_finder/services/services.dart';
import 'package:gas_station_finder/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';

class StationList extends StatefulWidget {
  final Position initialPosition;
  final LocationService locationService;

  const StationList({
    required this.initialPosition,
    required this.locationService,
    Key? key,
  }) : super(key: key);

  @override
  _StationListState createState() => _StationListState();
}

class _StationListState extends State<StationList> {
  late Position _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initialPosition;
    context.read<StationListBloc>().add(GetGasStation(
          _currentPosition.latitude,
          _currentPosition.longitude,
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gas Stations'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<StationListBloc>().add(GetGasStation(
                      _currentPosition.latitude,
                      _currentPosition.longitude,
                    ));
              },
              icon: const Icon(Icons.sync),
            )
          ],
        ),
        body: BlocConsumer<StationListBloc, StationListState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status.isFailure) {
              return Text(state.error ?? '').setCenter();
            }
            if (state.status.isLoading) {
              return const ShowProgress();
            }
            if (state.status.isSuccess) {
              final items = state.model!.results.items;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.title),
                    trailing: Text(item.getETA(widget.locationService)),
                    subtitle: Text(item.cleanedVicinity),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
