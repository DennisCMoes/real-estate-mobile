class House {
  String image;
  String street;
  int bedrooms;
  int bathrooms;
  int sqFeet;
  int price;

  House(this.image, this.street, this.bedrooms, this.bathrooms, this.sqFeet,
      this.price);

  House.fromJson(Map<String, dynamic> json)
      : image = json['image'] as String,
        street = json['street'] as String,
        bedrooms = json['bedrooms'] as int,
        bathrooms = json['bathrooms'] as int,
        sqFeet = json['sqFeet'] as int,
        price = json['price'] as int;
}
