void functionPlayground() {
  classicalFunctions();
  optionalParameters();
  consumeClosure();
}

void printMyName(String name) {
  print('Hello $name');
}

int add(int a, int b) {
  return a + b;
}

int factorial(int number) {
  if (number <= 0) {
    return 1;
  }

  return number * factorial(number - 1);
}

void classicalFunctions() {
  print('Anna');
  print('Irina');

  final sum = add(5, 6);
  print(sum);

  print('10 Factorial is ${factorial(10)}');
}

// Wrap optional parameters in square brackets
void unnamed([String? name, int? age]) {
  final actualName = name ?? 'Unknown';
  final actualAge = age ?? 0;
  print('$actualName is $actualAge years old.');
}

// Wrap named optional parameters in curly brackets
void named({String? greeting, String? name}) {
  final actualGreeting = greeting ?? 'Hello';
  final actualName = name ?? 'Mystery Person';
  print('$actualGreeting, $actualName!');
}

// You can mix required parameters with optional
// Optional parameters can also have default values
String duplicate(String name, {int times = 1}) {
  String merged = '';
  for (int i = 0; i < times; i++) {
    merged += name;
    if (i != times - 1) {
      merged += ' ';
    }
  }

  return merged;
}

void optionalParameters() {
  unnamed('Huxley', 3);
  unnamed();

  // Notice how parameters can be in any order
  // FLutter uses this a lot. You should too.
  named(greeting: 'Habari na Jambo');
  named(name: 'Ruto Raila');
  named(name: 'Samuel Odinga', greeting: 'Sema');

  final multiply = duplicate('Melo', times: 5);
  print(multiply);
}

///////////////////
// Closure Time! //
///////////////////

// Define closure types for easy use
typedef int numberGetter();

int powerOfTwo({required numberGetter getter}) {
  return getter() * getter();
}

// Or don't define the closure ahead of time
// and just describe it in the function signature
void callbackExample(void callback(String value)) {
  callback('Hello Callback');
}

void closureInvoker(void Function() aClosure) {
  aClosure();
}

void consumeClosure() {
  // final firstClassFunction = () {
  //   print('I am closure!');
  // };

  closureInvoker(() {
    print('I am written inline!');
  });

  final getFour = () => 4;
  final squared = powerOfTwo(getter: getFour);
  print(squared);

  callbackExample((result) {
    print(result);
  });
}
