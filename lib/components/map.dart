import 'package:flutter/material.dart';
import 'package:real_estate/models/location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapComponent extends StatefulWidget {
  const MapComponent({super.key});

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  late MapController mapController;
  LocationModel? currentLocation;

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    getCurrentLocation();
  }

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location service disabled'),
          content: const Text('Please enable location services.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );

      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Location Permission Denied"),
            content: const Text("Please grant location permission."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );

        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLocation = LocationModel(
          latitude: position.latitude, longitude: position.longitude);

      // currentLocation = LocationModel(latitude: 52.453223, longitude: 4.822007);

      mapController.move(
          LatLng(currentLocation!.latitude, currentLocation!.longitude), 15.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          initialCenter: LatLng(currentLocation?.latitude ?? 0.0,
              currentLocation?.longitude ?? 0.0),
          initialZoom: 15.0),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            if (currentLocation != null)
              Marker(
                point: LatLng(
                  currentLocation!.latitude,
                  currentLocation!.longitude,
                ),
                child: const Icon(
                  Icons.location_on,
                ),
              ),
          ],
        )
      ],
    );
  }
}
