class Pizza {
  int? id;
  String? pizzaName;
  String? description;
  double? price;
  String? imageUrl;

  // Transforming the Map objects into Pizza objects
  Pizza.fromJson(Map<String, dynamic> json) {
    id = json[id];
    pizzaName = json['pizzaName'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
  }

  // transform a Dart class into a JSON string
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
