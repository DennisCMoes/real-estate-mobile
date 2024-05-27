import 'package:flutter/material.dart';
import 'package:real_estate/components/dot.dart';

class HouseCard extends StatefulWidget {
  const HouseCard({super.key});

  @override
  State<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends State<HouseCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('detail');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Hero(
                  tag: 'HouseImg',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/house_img.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "€500,000",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text("841 Grove St"),
            const Row(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
