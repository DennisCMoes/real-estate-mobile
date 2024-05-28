import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/instance_manager.dart';
import 'package:real_estate/components/house_card.dart';
import 'package:real_estate/main.dart';
import 'package:real_estate/components/map.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String cityName = "";
  final Controller controller = Get.put(Controller());
  List<String> chipLabels = ["Buy power", "Search", "Feed", "Favs", "Offers"];
  String selectedChip = "Search";

  @override
  void initState() {
    super.initState();

    getCityName();
  }

  void getCityName() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      cityName = placemarks[0].locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.houses.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Buying",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          itemCount: chipLabels.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 6),
                          itemBuilder: (context, index) => Theme(
                            data: ThemeData(splashColor: Colors.blue[200]),
                            child: ActionChip(
                              label: Text(chipLabels[index]),
                              onPressed: () {
                                setState(() {
                                  selectedChip = chipLabels[index];
                                });
                              },
                              backgroundColor: selectedChip == chipLabels[index]
                                  ? Colors.blue[100]
                                  : Colors.transparent,
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              padding: const EdgeInsets.all(0),
                              // labelStyle: const TextStyle(color: Colors.black45),
                              labelStyle: selectedChip == chipLabels[index]
                                  ? TextStyle(color: Colors.blue[900])
                                  : const TextStyle(color: Colors.black45),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MapComponent(houses: controller.houses),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 12,
                            blurRadius: 30,
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom,
                          top: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "${controller.houses.length} houses ",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                    TextSpan(
                                      text: "in $cityName",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
                                  ],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    HouseCard(house: controller.houses[index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemCount: controller.houses.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
