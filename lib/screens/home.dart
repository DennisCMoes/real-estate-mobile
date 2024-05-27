import 'package:flutter/material.dart';
import 'package:real_estate/screens/detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen"),
      ),
      body: Center(
        child: Column(
          children: [
            const Hero(
              tag: 'HouseImg',
              child: Image(
                image: AssetImage('assets/images/house_img.jpg'),
                width: 80,
              ),
            ),
            ElevatedButton(
              child: const Text("Press me"),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const DetailScreen(),
                    transitionDuration: const Duration(milliseconds: 350),
                    fullscreenDialog: true,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(0.0, 1.0);
                      var end = Offset.zero;
                      var curve = Curves.easeOutCubic;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
