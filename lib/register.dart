import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication.dart';
import 'package:flutter_app/book_page.dart';

import 'package:flutter_app/validator.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text("Reading List"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade400,
        toolbarHeight: 70,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      body: Column(
        children: [
          const Image(
            image: AssetImage("graphics/bookshelf.jpg"),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Register",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          Form(
            key: _registerFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailTextController,
                  focusNode: _focusEmail,
                  validator: (value) => Validator.validateEmail(email: value),
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _passwordTextController,
                  focusNode: _focusPassword,
                  validator: (value) =>
                      Validator.validatePassword(password: value),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 24.0),
                _isProcessing
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            setState(() {
                              _isProcessing = true;
                            });
                            if (_registerFormKey.currentState.validate()) {
                              User user = await Authentication
                                  .registerUsingEmailPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                              );
                              setState(() {
                                _isProcessing = false;
                              });
                              if (user != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => BookPage(user),
                                  ),
                                  ModalRoute.withName('/'),
                                );
                              }
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(144, 40),
                            side: BorderSide(
                              color: Colors.deepPurple.shade400,
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
