
//kendi oluşturduğumuz türler adres, puanlama, isim ve konum bilgilerini içeren model
class PlaceModel {
  final String vicinity;
  var rating;
  final List<String> types;
  final bool isOpen;
  final String icon;
  final String name;
  final Map location;

  PlaceModel(
      {required this.vicinity,
      this.rating,
      required this.types,
      required this.isOpen,
      required this.icon,
      required this.name,
      required this.location});

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    print(json['rating']);
    return PlaceModel(
        icon: json['icon'],
        name: json['name'],
        types: List<String>.from(json['types']),
        vicinity: json['vicinity'],
        isOpen: true,
        location: {
          'lat': json['geometry']['location']['lat'],
          'lng': json['geometry']['location']['lng']
        },
        rating: json['rating']);
  }
}
