import 'package:flutter/material.dart';
import 'package:real_estate/components/primary_button.dart';
import 'package:real_estate/transitions/slide_from_bottom.dart';

class OfferAcceptedScreen extends StatefulWidget {
  const OfferAcceptedScreen({super.key});

  @override
  State<OfferAcceptedScreen> createState() => _OfferAcceptedScreenState();
}

class _OfferAcceptedScreenState extends State<OfferAcceptedScreen> {
  bool _heroAnimationComplete = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)?.animation?.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(const Duration(milliseconds: 500));

          setState(() {
            _heroAnimationComplete = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Hero(
              tag: 'HouseImg',
              child: Image(
                image: AssetImage('assets/images/house_img.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_heroAnimationComplete)
            SlideFromBottom(
              durationMS: 400,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.4,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 12,
                          blurRadius: 30,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Transform.rotate(
                            angle: 0.7854,
                            child: const Icon(
                              Icons.key,
                              size: 64,
                              color: Colors.blue,
                            ),
                          ),
                          const Text(
                            'Offer accepted',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const FractionallySizedBox(
                            widthFactor: 0.7,
                            child: Text(
                              'Welcome home! We are wishing you all the best in your new home.',
                            ),
                          ),
                          Column(
                            children: [
                              PrimaryButton(
                                label: 'Schedule final walkthrough',
                                onClick: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    'home',
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    'home',
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: const Text("SKIP"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
