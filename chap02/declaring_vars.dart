// ignore_for_file: unnecessary_null_comparison

main() {
  variablePlayground();
}

void variablePlayground() {
  basicTypes();
  untypedVariables();
  typeInterpolation();
  immutableVariables();
}

void basicTypes() {
  int four = 4;
  double pi = 3.14;
  num someNum = 345;
  bool yes = true;
  bool no = false;
  int? nothing;

  print(four);
  print(pi);
  print(someNum);
  print(yes);
  print(no);
  print(nothing == null);
}

void untypedVariables() {
  dynamic something = 13.3;
  print(something.runtimeType); // outputs 'double'
}

void typeInterpolation() {
  var anInteger = 15;
  var aDouble = 35.5;
  var aBoolean = false;

  print(anInteger.runtimeType);
  print(anInteger);

  print(aDouble.runtimeType);
  print(aDouble);

  print(aBoolean.runtimeType);
  print(aBoolean);
}

void immutableVariables() {
  final int immutableInteger = 34;
  final double immutableDouble = 1.435;

  // Type annotaion is optional
  final interpolatedInteger = 10;
  final interpolatedDouble = 73.4;

  print(interpolatedInteger);
  print(interpolatedDouble);

  const aFullySealedVariable = true;
  print(aFullySealedVariable);
}

/*
These modifiers indicate whether the variable is mutable. var is completely mutable as its
value can be reassigned at any point. final variables can only be assigned once, but by
using objects, you can change the value of its fields. const variables are compile-time
constants and are fully immutable; nothing about these variables can be changed once
they've been assigned.
*/
var animal = 'Duck';
final numValue = 42;
const isBoring = true;

// Please note that you can only specify a type when you're using the final modifier, as
// follows:
final int numValue2 = 42; // this is ok
// NOT OK: const int or var int.

/* 
After the final modifier, you can optionally declare the variable type, from simple built-in
types such as int, double, and bool, to your own more complex custom types. This
notation is standard for languages such as Java, C, C++, Objective-C, and C#.
*/

/* 
The difference between final and const is subtle but important. A final variable must
have a value assigned to it in the same statement where it was declared, and that variable
cannot be reassigned to a different value:
*/
final meaningOfLife = 42;
// meaningOfLife = 64; // This will throw an error

/* 
const takes this one step further. const values must be determined at compile time, new
values are blocked from being assigned to const variables, and the internal contents of that
variable must also be completely sealed. Typically, this is indicated by having the object
have a const constructor, which only allows immutable values to be used. Since their
value is already determined at compile time, const values also tend to be faster than
variables.
*/
