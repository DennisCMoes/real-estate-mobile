import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/components/dot.dart';
import 'package:real_estate/components/primary_button.dart';
import 'package:real_estate/main.dart';
import 'package:real_estate/models/house.dart';
import 'package:real_estate/screens/offer.dart';
import 'package:real_estate/transitions/fade.dart';
import 'package:real_estate/transitions/slide_from_bottom.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Controller controller = Get.put(Controller());
  final oCcy = NumberFormat("#,##0", "en_US");
  bool _transitionComplete = false;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const OfferScreen(),
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)?.animation?.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          setState(() {
            _transitionComplete = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Hero(
                tag:
                    "${controller.selectedHouse!.street.replaceAll(' ', '-')}-house",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: const Image(
                    image: AssetImage('assets/images/house_img.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (_transitionComplete)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: FadeWidget(
                      child: SlideFromBottom(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$${oCcy.format(controller.selectedHouse!.price)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '5 hrs ago',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    // '841 Grove St \nLos Angeles, CA 90042',
                                    controller.selectedHouse!.street,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${controller.selectedHouse!.bedrooms} bd',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Dot(),
                                Text(
                                  '${controller.selectedHouse!.bathrooms} ba',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Dot(),
                                Text(
                                  '${controller.selectedHouse!.sqFeet} ft',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Dot(),
                                const Text(
                                  'single family',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            PrimaryButton(
                              label: 'Make an offer',
                              onClick: () {
                                Navigator.of(context)
                                    .pushReplacement(_createRoute());
                                // Navigator.pushNamed(context, 'offer');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
