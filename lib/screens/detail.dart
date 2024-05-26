import 'package:flutter/material.dart';
import 'package:real_estate/components/dot.dart';
import 'package:real_estate/components/primary_button.dart';
import 'package:real_estate/transitions/fade.dart';
import 'package:real_estate/transitions/slide_from_bottom.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail screen"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryButton(
          label: 'Make an offer',
          onClick: () {
            Navigator.pushNamed(context, 'offer');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: const Hero(
                tag: 'HouseImg',
                child: Image(
                  image: AssetImage('assets/images/house_img.jpg'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: FadeWidget(
                child: SlideFromBottom(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '€250,000',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '5 hrs ago',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '841 Grove St \nLos Angeles, CA 90042',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '3 bd',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          Dot(),
                          Text(
                            '2 ba',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          Dot(),
                          Text(
                            '1230 ft',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          Dot(),
                          Text(
                            'single family',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
