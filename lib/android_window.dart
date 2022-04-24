import 'package:android_window/android_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:landscape_textfield/landscape_textfield.dart';

class AndroidWindowApp extends StatelessWidget {
  const AndroidWindowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
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
      child: AndroidWindow(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.orange,
              width: 2.5,
            )),
            child: Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                backgroundColor: Colors.orange,
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
                          AndroidWindow.close();
                        },
                        child: const Text("Close Window"),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      LandscapeTextField.form(
                        controller: _nameController,
                        onChanged: (text) {},
                        decoration: const InputDecoration(
                            hintText: 'Type something here...'),
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            const snackBar = SnackBar(
                                content: Text(
                              'Write Something',
                              textAlign: TextAlign.center,
                            ));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("COPY TEXT"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
