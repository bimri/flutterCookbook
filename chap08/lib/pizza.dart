class Pizza {
  int? id;
  String? pizzaName;
  String? description;
  double? price;
  String? imageUrl;

  Pizza();

  // factory constructor method
  factory Pizza.fromJsonOrNull(Map<String, dynamic> json) {
    Pizza pizza = Pizza();
    pizza.id = (json['id'] != null) ? int.tryParse(json['id'].toString()) : 0;
    pizza.pizzaName =
        (json['pizzaName'] != null) ? json['pizzaName'].toString() : '';
    pizza.description =
        (json['description'] != null) ? json['description'].toString() : '';
    pizza.price = (json['price'] != null &&
            double.tryParse(json['price'].toString()) != null)
        ? json['price']
        : 0.0;
    pizza.imageUrl =
        (json['imageUrl'] != null) ? json['imageUrl'].toString() : '';

    if (pizza.id == 0 || pizza.pizzaName?.trim() == '') {
      return null;
    }
    return pizza;
  }

  // Transforming the Map objects into Pizza objects
  Pizza.fromJson(Map<String, dynamic> json) {
    id = (json['id'] != null) ? int.tryParse(json['id'].toString()) : 0;
    pizzaName = (json['pizzaName'] != null) ? json['pizzaName'].toString() : '';
    description =
        (json['description'] != null) ? json['description'].toString() : '';
    price = (json['price'] != null &&
            double.tryParse(json['price'].toString()) != null)
        ? json['price']
        : 0.0;
    imageUrl = (json['imageUrl'] != null) ? json['imageUrl'].toString() : '';
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
