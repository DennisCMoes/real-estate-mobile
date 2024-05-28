import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/main.dart';
import 'package:real_estate/models/house.dart';
import 'package:real_estate/models/location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapComponent extends StatefulWidget {
  final List<House> houses;

  const MapComponent({super.key, required this.houses});

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  Controller controller = Get.put(Controller());
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

      mapController.move(
          LatLng(currentLocation!.latitude, currentLocation!.longitude), 15.0);
    });
  }

  double calculateTextWidth(String text, TextStyle style) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return painter.size.width + 10;
  }

  String formatPrice(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}k';
    } else {
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          initialCenter: LatLng(currentLocation?.latitude ?? 0.0,
              currentLocation?.longitude ?? 0.0),
          initialZoom: 10.0),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: widget.houses.map((house) {
            return Marker(
              point: LatLng(
                house.location!.latitude,
                house.location!.longitude,
              ),
              width: calculateTextWidth(
                house.price.toString(),
                const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                shadowColor: Colors.black45,
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    controller.selectHouse(house);
                    Navigator.of(context).pushNamed('detail', arguments: house);
                  },
                  child: Center(
                    child: Text(
                      formatPrice(house.price),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // MarkerLayer(
        //   markers: [
        //     if (currentLocation != null)
        //       Marker(
        //         point: LatLng(
        //           currentLocation!.latitude,
        //           currentLocation!.longitude,
        //         ),
        //         width: calculateTextWidth(
        //           "200k",
        //           const TextStyle(
        //             fontSize: 14,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //         child: Material(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(4),
        //           shadowColor: Colors.black45,
        //           elevation: 3,
        //           child: InkWell(
        //             onTap: () {},
        //             child: const Center(
        //               child: Text(
        //                 "200k",
        //                 style: TextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //                 overflow: TextOverflow.clip,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //   ],
        // )
      ],
    );
  }
}
