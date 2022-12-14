import 'package:flutter/material.dart';
import 'pizza.dart';
import 'httphelper.dart';

class PizzaDetail extends StatefulWidget {
  final Pizza? pizza;
  final bool? isNew;
  const PizzaDetail(Pizza pizza, {Key? key, this.pizza, this.isNew}) : super(key: key);

  @override
  State<PizzaDetail> createState() => _PizzaDetailState();
}

class _PizzaDetailState extends State<PizzaDetail> {
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();
  String postResult = '';

  // @override
  // void initState() {
  //   if (!widget.isNew!) {
  //     txtId.text = widget.pizza.id.toString();
  //     txtName.text = widget.pizza.pizzaName!;
  //     txtDescription.text = widget.pizza.description!;
  //     txtPrice.text = widget.pizza.price!.toString();
  //     txtImageUrl.text = widget.pizza.imageUrl!;
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                postResult,
                style: TextStyle(
                    backgroundColor: Colors.green[200], color: Colors.black),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtId,
                decoration: const InputDecoration(hintText: 'Insert ID'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtName,
                decoration:
                    const InputDecoration(hintText: 'Insert Pizza Name'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtDescription,
                decoration:
                    const InputDecoration(hintText: 'Insert Description'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtPrice,
                decoration: const InputDecoration(hintText: 'Insert Price'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtImageUrl,
                decoration: const InputDecoration(hintText: 'Insert Image Url'),
              ),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                  child: const Text('Send Post'),
                  onPressed: () {
                    postPizza();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future postPizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza();
    pizza.id = int.tryParse(txtId.text);
    pizza.pizzaName = txtName.text;
    pizza.description = txtDescription.text;
    pizza.price = double.tryParse(txtPrice.text);
    pizza.imageUrl = txtImageUrl.text;
    String result = await helper.postPizza(pizza);
    setState(() {
      postResult = result;
    });
    return result;
  }

  // Future savePizza() async {
  //   String result = '';
  //   if (widget.isNew!) {
  //     result = await helper.postPizza(pizza);
  //   } else {
  //     result = await helper.putPizza(pizza);
  //   }
  //   setState(() {
  //     postResult = result;
  //   });
  //   return result;
  // }
}
