import 'package:android_window/main.dart' as android_window;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:landscape_textfield/landscape_textfield.dart';

import 'android_window.dart';

@pragma('vm:entry-point')
void androidWindow() {
  runApp(const AndroidWindowApp());
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LandscapeTextFieldWrapper(
      buttonBuilder: (closeKeyboard) {
        return ElevatedButton(
          onPressed: closeKeyboard,
          child: const Text("Ok"),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Overlay Example"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    android_window.open(size: const Size(700, 1000));
                  },
                  child: const Text("Open Overlay"),
                ),
                ElevatedButton(
                  onPressed: () {
                    android_window.close();
                  },
                  child: const Text("Close Overlay"),
                ),
                const SizedBox(
                  height: 100,
                ),
                LandscapeTextField.form(
                  controller: _nameController,
                  onChanged: (text) {},
                  decoration:
                      const InputDecoration(hintText: 'Type something here...'),
                  onSubmitted: (_) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      const snackBar = SnackBar(
                          content: Text(
                        'Copied!',
                        textAlign: TextAlign.center,
                      ));
                      Clipboard.setData(
                          ClipboardData(text: _nameController.text));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      const snackBar = SnackBar(
                          content: Text(
                        'Write Something',
                        textAlign: TextAlign.center,
                      ));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text("COPY TEXT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
