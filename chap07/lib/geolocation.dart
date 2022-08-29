import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';

  // obvious choice should be leveraging the initState method,
  // which only gets called once: recommended to keep initState synchronous
  @override
  void initState() {
    getPosition().then((Position myPos) {
      myPosition = 'Latitude: ${myPos.latitude} -Longitude: ${myPos.longitude}';
      setState(() {
        myPosition = myPosition;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location')),
      body: Center(
          child: FutureBuilder(
        future: getPosition(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Something terrible happened!');
            }
            return Text(snapshot.data);
          } else {
            return const Text('');
          }
        },
      )),
    );
  }

  Future<Position> getPosition() async {
    await Future<int>.delayed(const Duration(seconds: 3));
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}


/* 
Using the FutureBuilder to let Flutter manage your Futures

The pattern of retrieving some data asynchronously and updating the user interface based
on that data is quite common. So common in fact that in Flutter, there is a widget that helps
you remove some of the boilerplate code you need to build the UI based on Futures: it's the
FutureBuilder widget.

You can use a FutureBuilder to integrate Futures within a widget tree that automatically
updates its content when the Future updates. As a FutureBuilder builds itself based on
the status of a Future, you can skip the setState instruction, and Flutter will only rebuild
the part of the user interface that needs updating.

FutureBuilder implements reactive programming, as it will take care of updating the user
interface as soon as data is retrieved, and this is probably the main reason why you should
use it in your code: it's an easy way for the UI to react to data in a Future.
FutureBuilder requires a future property, containing the Future object whose content
you want to show, and a builder. In the builder, you actually build the user interface,
but you can also check the status of the data: in particular, you can leverage the
connectionState of your data so you know exactly when the Future has returned its
data.
*/

/* 
In this recipe, getPosition is the Future we will pass to the FutureBuilder. In this case,
initState is not required at all: FutureBuilder takes care of updating the user interface
whenever there's a change in the data and state information.

Note that there are two properties we are setting for FutureBuilder: the future, which in
this example is our getPosition() method, and the builder.

The builder takes the current context and an AsyncSnapshot, containing all the Future
data and state information: the builder must return a widget.

The connectionState property of the AsyncSnapshot object makes you check the state
of the Future. In particular, you have the following:
    - waiting means the Future was called but has not yet completed its execution.
    - done means that the execution completed.
*/
