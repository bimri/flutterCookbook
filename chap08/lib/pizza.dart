// we simply used constants instead of repeating the name
// of the keys for our JSON data.
const keyId = 'id';
const keyName = 'pizzaName';
const keyDescription = 'description';
const keyPrice = 'price';
const keyImage = 'imageUrl';

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
    pizza.id = (json[keyId] != null) ? int.tryParse(json[keyId].toString()) : 0;
    pizza.pizzaName = (json[keyName] != null) ? json[keyName].toString() : '';
    pizza.description =
        (json[keyDescription] != null) ? json[keyDescription].toString() : '';
    pizza.price = (json[keyPrice] != null &&
            double.tryParse(json[keyPrice].toString()) != null)
        ? json[keyPrice]
        : 0.0;
    pizza.imageUrl = (json[keyImage] != null) ? json[keyImage].toString() : '';
    if (pizza.id == 0 || pizza.pizzaName?.trim() == '') {}
    return pizza;
  }

  // Transforming the Map objects into Pizza objects
  Pizza.fromJson(Map<String, dynamic> json) {
    id = (json[keyId] != null) ? int.tryParse(json['id'].toString()) : 0;
    pizzaName = (json[keyName] != null) ? json[keyName].toString() : '';
    description =
        (json[keyDescription] != null) ? json[keyDescription].toString() : '';
    price = (json[keyPrice] != null &&
            double.tryParse(json[keyPrice].toString()) != null)
        ? json[keyPrice]
        : 0.0;
    imageUrl = (json[keyImage] != null) ? json[keyImage].toString() : '';
  }

  // transform a Dart class into a JSON string
  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
    };
  }
}
