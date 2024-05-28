import 'package:faker/faker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

import 'package:real_estate/models/location_model.dart';

class House {
  String image;
  String street;
  int bedrooms;
  int bathrooms;
  int sqFeet;
  int price;
  LocationModel? location;

  House(this.image, this.street, this.bedrooms, this.bathrooms, this.sqFeet,
      this.price, this.location);

  House.fromJson(Map<String, dynamic> json)
      : image = json['image'] as String,
        street = json['street'] as String,
        bedrooms = json['bedrooms'] as int,
        bathrooms = json['bathrooms'] as int,
        sqFeet = json['sqFeet'] as int,
        price = json['price'] as int;

  static Future<House> fromRandom() async {
    var rng = Random();

    // Generate rounded price
    int randomPrice = rng.nextInt(1000000) + 100000;
    int roundedPrice = ((randomPrice + 500) ~/ 1000) * 1000;

    LocationModel randomLocation = await generateRandomCoordinates();

    return House('image', faker.address.streetAddress(), rng.nextInt(3) + 1,
        rng.nextInt(4) + 1, rng.nextInt(1200), roundedPrice, randomLocation);
  }

  static Future<LocationModel> generateRandomCoordinates() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Random random = Random();

    const double earthRadius = 6371.0; // Earth's radius in KM
    double radiusInDegrees = 0.5 / earthRadius;

    double u = random.nextDouble();
    double v = random.nextDouble();
    double w = radiusInDegrees * sqrt(u);

    double t = 2 * pi * v;
    double x = w * cos(t);
    double y = w * sin(t);

    // Adjust the x-coordinate for the shrinking of the east west distances
    double newX = x / cos(position.latitude * pi / 180);

    double foundLongitude = position.longitude + newX * 180 / pi;
    double foundLatitude = position.latitude + y * 180 / pi;

    return LocationModel(latitude: foundLatitude, longitude: foundLongitude);
  }
}
