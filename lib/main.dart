import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/models/house.dart';
import 'package:real_estate/screens/accepted.dart';
import 'package:real_estate/screens/detail.dart';
import 'package:real_estate/screens/final_walkthrough.dart';
import 'package:real_estate/screens/home.dart';
import 'package:real_estate/screens/offer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Controller controller = Get.put(Controller());

  for (var i = 0; i < 10; i++) {
    controller.addHouse(await House.fromRandom());
  }

  runApp(const GetMaterialApp(home: MyApp()));
}

class Controller extends GetxController {
  RxList<House> houses = <House>[].obs;
  House? selectedHouse;

  addHouse(House house) => houses.add(house);
  selectHouse(House house) => selectedHouse = house;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'offer': (context) => const OfferScreen(),
        'accepted': (context) => const OfferAcceptedScreen(),
        'final-walkthrough': (context) => const FinalWalkthroughScreen()
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'detail':
            return MaterialPageRoute(
              builder: (context) => const DetailScreen(),
              fullscreenDialog: true,
            );
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
