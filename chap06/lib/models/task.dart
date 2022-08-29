// The best place to start is the data layer. This will give you a clear view of your
// app, without going into the details of your user interface.

import 'package:chap06/repositories/repository.dart';

class Task {
  String description;
  bool complete;
  final int id;

  Task({
    required this.id,
    this.complete = false,
    this.description = '',
  });

  // need to add the serialization and deserialization methods. These
  // functions will take the data from a generic Model and return a more usable
  // strongly typed object.
  Task.fromModel(Model model)
      : id = model.id,
        description = model.data['description'],
        complete = model.data['complete'];

  Model toModel() =>
      Model(id: id, data: {'description': description, 'complete': complete});
}
