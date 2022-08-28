// The best place to start is the data layer. This will give you a clear view of your
// app, without going into the details of your user interface.

class Task {
  String description;
  bool complete;

  Task({
    this.complete = false,
    this.description = '',
  });
}
