import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: const Image(
                  image: AssetImage('assets/images/house_img.jpg'),
                ),
              ),
              const Row(
                children: [
                  Text('€250,000'),
                  Text('5 hrs ago'),
                ],
              ),
              const Row(
                children: [Text('841 Grove St Los Angeles, CA 90042')],
              ),
              const Row(
                children: [
                  Text('3 bd'),
                  Text('2 ba'),
                  Text('1230 ft'),
                  Text('single family')
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'offer');
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Make an offer'),
                ),
              )
            ],
          ),
        ));
  }
}
