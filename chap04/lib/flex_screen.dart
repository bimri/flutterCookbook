import 'package:flutter/material.dart';
import 'labeled_container.dart';

class FlexScreen extends StatelessWidget {
  const FlexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flexible and Expanded'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ..._header(context, 'Expanded'),
            _buildExpanded(context),
            ..._header(context, 'Flexible'),
            _buildFlexible(context),
            Expanded(
              child: Container(),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> _header(BuildContext context, String text) {
    return [
      const SizedBox(
        height: 20,
      ),
      Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      )
    ];
  }

  Widget _buildExpanded(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: const <Widget>[
          LabeledContainer(
            width: 100,
            color: Colors.green,
            text: '100',
            textColor: Colors.black,
          ),
          Expanded(
            child: LabeledContainer(
              color: Colors.purple,
              text: 'The Remainder',
              textColor: Colors.white,
              width: 40,
            ),
          ),
          LabeledContainer(
            width: 40,
            color: Colors.green,
            text: '40',
            textColor: Colors.black,
          )
        ],
      ),
    );
  }

  Widget _buildFlexible(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: const <Widget>[
          Flexible(
            flex: 1,
            child: LabeledContainer(
              color: Colors.blue,
              text: '25%',
              textColor: Colors.black,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 30,
            ),
            child: Text(
              'Pinned to the bottom',
            )),
      ),
    );
  }
}
