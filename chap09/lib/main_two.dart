import 'package:flutter/material.dart';
// import 'package:chap09/stream_two.dart';
import 'countdown_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  TimerBLoC? timerBloc;
  int? seconds;

  late Stream<int?> numberStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC'),
      ),

      body: StreamBuilder(
        stream: timerBloc?.secondsStream,
        initialData: seconds,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('Error!');
          }
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data.toString(),
                style: const TextStyle(fontSize: 96),
              ),
            );
          } else {
            return const Center();
          }
        }),
      ),
      // body: StreamBuilder(
      //     stream: numberStream,
      //     initialData: 0,
      //     builder: (context, snapshot) {
      //       if (snapshot.hasError) {
      //         debugPrint('Error!');
      //       }
      //       if (snapshot.hasData) {
      //         return Center(
      //             child: Text(
      //           snapshot.data.toString(),
      //           style: const TextStyle(fontSize: 96),
      //         ));
      //       } else {
      //         return const Center();
      //       }
      //     }),
    );
  }

  @override
  void initState() {
    timerBloc = TimerBLoC();
    seconds = timerBloc?.seconds;
    timerBloc?.countDown();
    // numberStream = NumberStream().getNumbers();
    super.initState();
  }
}
