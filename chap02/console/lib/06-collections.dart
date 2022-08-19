void collectionPlayground() {
  listPlayground();
  mapPlayground();
  setPlayground();
  collectionControlFlow();
}

void listPlayground() {
  // Creating  with list literal syntax
  final numbers = [1, 2, 3, 4, 5, 7];

  numbers.add(10);
  numbers.addAll([4, 5, 6, 78]);

  // Assigning via subscript
  numbers[1] = 34;

  print('The second number is ${numbers[1]}');

  // enumerating a list
  for (int number in numbers) {
    print(number);
  }
}

void mapPlayground() {
  // Map literal syntax
  final Map ages = {
    'Mose': 24,
    'Ptah': 67890,
    'Hathor': 56755,
  };

  // Subscript syntax uses the key type.
  // A string in this case
  ages['Osiris'] = 7654567876545678;

  final ageOfPtah = ages['Ptah'];
  print('Ptah the ancient is $ageOfPtah years old.');

  ages.remove('Mose');

  ages.forEach((dynamic name, dynamic age) {
    print('$name is $age years old');
  });
}

void setPlayground() {
  // Set literal, similar to Map, but no keys
  final ministers = {'Justin', 'Stephen', 'Paul', 'Jean', 'Kim', 'Brian'};
  ministers.addAll({'John', 'Pierre', 'Joe', 'Pierre'});

  // These sort of queries are much faster than Lists
  final isJustinAMinister = ministers.contains('Justin');
  print(isJustinAMinister);

  // Notice how 'Pierre' will only be printed once
  // In sets, duplicates are automatically rejected
  for (String primeMinister in ministers) {
    print('$primeMinister is a Prime Minister.');
  }
}

void collectionControlFlow() {
  // Dart now allows you to add control flow inside array declarations
  // These language features were developed specifically for Flutter

  // You can now include if states, for loops
  // and spread operators inside collections
  final addMore = true;
  final randomNumbers = [
    34,
    232,
    54,
    32,
    if (addMore) ...[
      534343,
      4423,
      3432432,
    ],
  ];

  final duplicated = [
    for (int number in randomNumbers) number * 2,
    for (int i = 0; i < 100; i++) i,
  ];

  print(duplicated);
}
