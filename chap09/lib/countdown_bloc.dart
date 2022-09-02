import 'dart:async';

class TimerBLoC {
  int seconds = 60;
  final StreamController _secondsStreamController = StreamController();
  Stream get secondsStream =>
      _secondsStreamController.stream.asBroadcastStream();
  StreamSink get secondsSink => _secondsStreamController.sink;

  // decreaseSeconds method waits for 1 second before decreasing the number of remaining
  // seconds and adding the new value to Sink.
  // By adding the value to the sink, any listener
  // will receive the new value and update the user interface as required:
  Future decreaseSeconds() async {
    await Future.delayed(const Duration(seconds: 1));
    seconds--;
    secondsSink.add(seconds);
  }

  countDown() async {
    for (var i = seconds; i > 0; i--) {
      await decreaseSeconds();
      returnSeconds(seconds);
    }
  }

  int returnSeconds(seconds) {
    return seconds;
  }

  void dispose() {
    _secondsStreamController.close();
  }
}
