import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  const DetailScreen(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Screen'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.amber),
                child: Hero(
                  tag: 'cup$index',
                  child: const Icon(
                    Icons.free_breakfast,
                    size: 96,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            )
          ],
        ));
  }
}

/* 
In order to create a Hero animation, you need to create two Hero widgets: one for the
source, and one for the destination.
*/
