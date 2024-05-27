import 'package:flutter/material.dart';
import 'package:real_estate/screens/accepted.dart';
import 'package:real_estate/screens/detail.dart';
import 'package:real_estate/screens/home.dart';
import 'package:real_estate/screens/offer.dart';

void main() {
  runApp(const MyApp());
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
      // routes: {
      //   'home': (context) => const HomeScreen(),
      //   'detail': (context) => const DetailScreen(),
      //   'offer': (context) => const OfferScreen(),
      //   'accepted': (context) => const OfferAcceptedScreen()
      // },
      home: const HomeScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "home":
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case "detail":
            return MaterialPageRoute(
              builder: (context) => const DetailScreen(),
              fullscreenDialog: true,
            );
          case "offer":
            return MaterialPageRoute(builder: (context) => const OfferScreen());
          case "accepted":
            return MaterialPageRoute(
                builder: (context) => const OfferAcceptedScreen());
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
