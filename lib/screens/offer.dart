import 'package:flutter/material.dart';
import 'package:real_estate/components/primary_button.dart';
import 'package:real_estate/screens/accepted.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const OfferAcceptedScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Hero(
                tag: 'HouseImg',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: const Image(
                    image: AssetImage('assets/images/house_img.jpg'),
                    fit: BoxFit.cover,
                    height: 280,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  CircleAvatar(
                    child: Text("MW"),
                  ),
                  SizedBox(width: 8),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: -6,
                    children: [
                      Text(
                        "Mark Won",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "available",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Text("Offer screen"),
              const Spacer(),
              PrimaryButton(
                label: 'Send offer for review',
                onClick: () {
                  Navigator.pushReplacement(context, _createRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
