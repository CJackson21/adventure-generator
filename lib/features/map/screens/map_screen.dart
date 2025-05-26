import 'package:flutter/material.dart';
import 'package:adventure_app/features/map/viewmodels/map_viewmodel.dart';
import 'package:adventure_app/features/map/widgets/map_builder.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MapViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_location_alt),
            onPressed: _viewModel.addDemoMarker,
            tooltip: 'Add Demo Marker',
          ),
        ],
      ),
      body: ValueListenableBuilder<MapConfigData>(
        valueListenable: _viewModel.mapConfigNotifier,
        builder: (context, mapConfig, child) {
          return buildFlutterMap(context, mapConfig);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.centerMapOnDefault,
        tooltip: 'Center Map',
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
