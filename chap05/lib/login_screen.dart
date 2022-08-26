import 'package:chap05/stopwatch.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String name = 'username';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  // Widget _buildSuccess() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       const Icon(
  //         Icons.check,
  //         color: Colors.orangeAccent,
  //       ),
  //       Text('Hi $name'),
  //     ],
  //   );
  // }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Runner'),
              validator: (text) =>
                  text!.isEmpty ? 'Enter the runner\'s name.' : null,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Enter the runner\'s email.';
                }

                final regex = RegExp('[^@]+@[^\.]+\..+');
                if (!regex.hasMatch(text)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validate,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }
    final name = _nameController.text;
    final email = _emailController.text;

    // Isn't it a little strange that you can hit a back button to return to a login
    // screen? In most apps, once you've logged in, that screen should no longer be
    // accessible. You can use the `Navigator's pushReplacement method` to achieve
    // this:

    /* 
    We also used the MaterialPageRoute class to represent our routes. This object will create
    a platform-aware transition between the two screens. On iOS, it will push onto the screen
    from right, while on Android, it will pop onto the screen from the bottom.

    Similar to ListView.builder, MaterialPageRoute also expects
    a WidgetBuilder instead of direct child. WidgetBuilder is a function that provides
    a BuildContext and expects a Widget to be returned:
    builder: (_) => StopWatch(name: name, email: email),
    This allows Flutter to delay the construction of the widget until it's needed. We also didn't
    need the context property, so it was replaced with an underscore.
    */
    
    Navigator.of(context).pushReplacementNamed(
      StopWatch.route,
      arguments: name,
    );
  }
}


/*
1. Article and video about keys by Emily Fortuna. Don't miss this one!: 
  https://medium.com/flutter/keys-what-are-they-good-for-13cb51742e7d

2. Forms: 
https://api.flutter.dev/flutter/widgets/Form-class.html

TextEditingControllers are objects that can be used to manipulate TextFields. 
    we only used them to extract the current value from our TextField, but they can
    also be used to programmatically set values in the widget, update text selections, and clear
    the fields.

The first validator is simple – it just checks if the text is empty. Validator functions
should return a string if the validation fails. If the validation is successful, then the function
should return a null. This is one of the very few cases in the entire Flutter SDK
where null is a good thing.

The Form widget that wraps the two TextFields is a non-rendering container widget. This
widget knows how to visit any of its children that are FormFields and invokes their
validators. If all the validator functions return null, the form is considered valid.
You used a GlobalKey to get access to the form's state class from outside the build
method. A simple way to explain GlobalKeys is that they do the opposite of
BuildContext. BuildContext is an object that can find parents in the widget tree. Keys
are objects that are used to retrieve a child widget. The topic is a bit more complex than
that, but in short, with the key, you can retrieve the Form's state. The FormState class has a
public method called validate that will call the validator on all its children.
*/
