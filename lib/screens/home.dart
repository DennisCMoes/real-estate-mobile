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
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ActionChip(
                                label: const Text("Buy power"),
                                onPressed: () {}),
                            const SizedBox(width: 8),
                            ActionChip(
                                label: const Text("Search"), onPressed: () {}),
                            const SizedBox(width: 8),
                            ActionChip(
                                label: const Text("Feed"), onPressed: () {}),
                            const SizedBox(width: 8),
                            ActionChip(
                                label: const Text("Favs"), onPressed: () {}),
                            const SizedBox(width: 8),
                            ActionChip(
                                label: const Text("Offers"), onPressed: () {}),
                          ],
                        ),
                      ),
                      const Expanded(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "12 houses in Highland Park",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
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
