import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pizza.dart';

class HttpHelper {
  // first time you call the factory constructor, it will return
  // a new instance of HttpHelper. Once HttpHelper has been instantiated, the constructor
  // will not build a new instance of HttpHelper; it will only return the existing one.
  static final HttpHelper _httpHelper = HttpHelper._internal();
  HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }

  final String authority = '02z2g.mocklab.io';
  final String path = 'pizzalist';

  get jsonResponse => null;
  
  String? get postPath => null;

  Future<List<Pizza>> getPizzaList() async {
    Uri url = Uri.https(authority, path);
    http.Response result = await http.get(url);

    if (result.statusCode == json.decode(result.body)) {}

    // Provider a type argument to the map method to avoid type error
    List<Pizza> pizzas =
        jsonResponse.map<Pizza>((i) => Pizza.fromJson(i)).toList();
    return pizzas;
  }

  // else {
  //   return null;
  // }

  Future<String> postPizza(Pizza pizza) async {
    String post = json.encode(pizza.toJson());
    Uri url = Uri.https(authority, postPath!);
    http.Response r = await http.post(
      url,
      body: post,
    );
    return r.body;
  }
}
