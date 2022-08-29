import 'repository.dart';

class InMemoryCache implements Repository {
  final _storage = Map<int, Model>();

  @override
  void clear() {
    _storage.clear();
  }

  // The most complex method is the create function, which needs to
  // generate a unique identifier for every element in the storage:
  @override
  Model create() {
    final ids = _storage.keys.toList()..sort();
    final id = (ids.length == 0) ? 1 : ids.last + 1;
    final model = Model(id: id);
    _storage[id] = model;
    return model;
  }

  // remaining methods are simple wrappers of the API map
  @override
  void delete(Model item) {
    _storage.remove(item.id);
  }

  @override
  Model? get(int id) {
    return _storage[id];
  }

  @override
  List<Model> getAll() {
    return _storage.values.toList(growable: false);
  }

  @override
  void update(Model item) {
    _storage[item.id] = item;
  }
}

/* 
Another requirement of the repository layer is that it cannot know anything about any
domain-specific models that we have defined for our project, namely the Plan and Task
models. Instead, we defined a transient Model class, which is just a map with an id
property. The id property is used to retrieve the object from storage. It is critical that this
value is unique; otherwise, your data will be overwritten.
*/
