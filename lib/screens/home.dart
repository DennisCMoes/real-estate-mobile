import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate/components/house_card.dart';
import 'package:real_estate/models/house.dart';
import 'package:real_estate/components/map.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<House> houses = [];

  @override
  void initState() {
    super.initState();
    loadHouseData();
  }

  Future<void> loadHouseData() async {
    final String response =
        await rootBundle.loadString('assets/data/houses.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      houses = data.map((json) => House.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: houses.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                const SafeArea(
                  child: Column(
                    children: [
                      Text("Buying"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Buy power"),
                          Text("Search"),
                          Text("Feed"),
                          Text("Favs"),
                          Text("Offers"),
                        ],
                      ),
                      Expanded(
                        child: MapComponent(),
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
                          left: 12,
                          right: 12,
                          top: 8,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "12 houses in Highland Park",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: houses.length,
                                itemBuilder: (context, index) {
                                  return const HouseCard();
                                },
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
