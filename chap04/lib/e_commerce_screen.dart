// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class ECommerceScreen extends StatelessWidget {
  const ECommerceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildToggleBar(),
              Image.asset('assets/woman_shopping.jpg'),
              const DealButtons(),
              _buildProductTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildProductTile(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/textiles.jpg',
            fit: BoxFit.fitHeight,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lorem Ipsum',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Text(
                      'Dolor sit amet, consectetur adipiscing elit. Quisque faucibus.')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _buildToggleBar() {
    return Row(
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Recommended',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Formal Wear',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Casual Wear',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purpleAccent,
      shape: const RoundedRectangleBorder(
          borderRadius:
              const BorderRadius.vertical(bottom: const Radius.circular(30))),
      leading: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Icon(Icons.home),
      ),
      title: const Text('Let\'s go shopping!'),
      elevation: 0,
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(Icons.shopping_cart),
        )
      ],
    );
  }
}

class DealButtons extends StatelessWidget {
  const DealButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: const Text(
                  'Best Sellers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: const Text(
                  'Daily Deals',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            const DealButton(
              text: 'Must buy in Summer',
              color: Colors.orangeAccent,
            ),
            const SizedBox(width: 10),
            const DealButton(
              text: 'Daily Deals',
              color: Colors.blue,
            ),
            const SizedBox(height: 15),
            Row(
              children: const <Widget>[
                DealButton(
                  text: 'Must buy in summer',
                  color: Colors.lightGreen,
                ),
                DealButton(text: 'Last Chance', color: Colors.redAccent),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class DealButton extends StatelessWidget {
  final String text;
  final Color color;
  const DealButton({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.lightGreen, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
