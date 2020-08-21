import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController _controller;
  String _mapStyle;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-7.619746885326489, 111.87637265771627),
    zoom: 17.0,
  );

  bool get themeIsDarkMode => _themeIsDarkMode();

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/json/googlemap_darktheme.json')
        .then((string) => _mapStyle = string);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  bool _themeIsDarkMode() {
    var currentTheme = BlocProvider.of<ThemeBloc>(context).state.themeMode;
    return currentTheme == ThemeMode.dark;
  }

  void _onMapCreated(GoogleMapController controller) {
    if (themeIsDarkMode) controller.setMapStyle(_mapStyle);
    this._controller = controller;

    _completer.complete(controller);
    _placeMarker(_initialCameraPosition.target);
  }

  void _placeMarker(LatLng position) async {
    final Marker marker = Marker(
      markerId: MarkerId('marker'),
      position: position,
      icon: BitmapDescriptor.fromBytes(
        themeIsDarkMode
            ? await getBytesFromAsset('assets/images/map-marker-dark.png', 75)
            : await getBytesFromAsset('assets/images/map-marker.png', 75),
      ),
    );

    setState(() => markers[marker.markerId] = marker);
    _controller.moveCamera(CameraUpdate.newLatLng(position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: GoogleMap(
        mapType: MapType.normal,
        mapToolbarEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
        onTap: _placeMarker,
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
