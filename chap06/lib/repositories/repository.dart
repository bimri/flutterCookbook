abstract class Repository {
  Model create();
  List<Model> getAll();
  Model? get(int id);
  void update(Model item);
  void delete(Model item);
  void clear();
}

class Model {
  final int id;
  final Map data;
  const Model({
    required this.id,
    this.data = const {},
  });
}

/* 
The next stage of the n-tier architecture we are going to discuss in this recipe is the bottommost
layer: the repositories, or the data layer. The purpose of a repository is to store and
retrieve data. This layer can be implemented as a database, web service, or in the case of the
Master Plan project, a simple in-memory cache. Unlike the controller layer, which is
business logic-aware, the repository layer is only concerned with getting and storing data
in its most abstract form. These classes should not even know about the model files that we
created earlier.

The reason why repositories are so purposefully ignorant is to keep them focused entirely
on their task – persistence. Communicating with a database or a web service can become
complicated if you have many small requirements. These concerns are typically beneath
business logic and are easier to resolve when you're only focused on abstract objects.
Remember, the whole goal of an n-tier architecture is to strictly separate responsibilities; we
let repositories do what they do best – store data – and let the higher layers handle the rest.

In fact, this same abstract class could be used to store data in a database, in one or more
files, or in a RESTful web service.
*/