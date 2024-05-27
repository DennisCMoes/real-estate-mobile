import 'package:flutter/material.dart';
import 'package:real_estate/components/dot.dart';
import 'package:real_estate/components/primary_button.dart';
import 'package:real_estate/screens/offer.dart';
import 'package:real_estate/transitions/fade.dart';
import 'package:real_estate/transitions/slide_from_bottom.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
                tag: 'HouseImg',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: const Image(
                    image: AssetImage('assets/images/house_img.jpg'),
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
                            const Row(
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Row(
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
                            const SizedBox(height: 8),
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
