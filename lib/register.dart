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
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _focusEmail,
                      validator: (value) =>
                          Validator.validateEmail(email: value),
                      cursorColor: Colors.deepPurple.shade400,
                      decoration: InputDecoration(
                        hintText: "Email",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple.shade400,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple.shade400,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _passwordTextController,
                      focusNode: _focusPassword,
                      validator: (value) =>
                          Validator.validatePassword(password: value),
                      obscureText: !_passwordVisible,
                      cursorColor: Colors.deepPurple.shade400,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple.shade400,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple.shade400,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple.shade400,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    _isProcessing
                        ? const CircularProgressIndicator()
                        : Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isProcessing = true;
                                    });
                                    if (_registerFormKey.currentState
                                        .validate()) {
                                      User user = await Authentication
                                          .registerUsingEmailPassword(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                      );
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                      if (user != null) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookPage(user),
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
                                    backgroundColor: Colors.deepPurple.shade100,
                                    fixedSize: const Size.fromHeight(40),
                                    side: BorderSide(
                                      color: Colors.deepPurple.shade400,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
