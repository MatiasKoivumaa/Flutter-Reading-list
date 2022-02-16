import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_app/authentication.dart';
import 'package:flutter_app/book_page.dart';
import './validator.dart';
import './register.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _passwordVisible = false;

  Future<FirebaseApp> _initializeFireBase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

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
        body: FutureBuilder(
          future: _initializeFireBase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  const Image(
                    image: AssetImage("graphics/bookshelf.jpg"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
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
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      User user = await Authentication
                                          .signInUsingEmailPassword(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                      );
                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookPage(user)));
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    fixedSize: const Size.fromHeight(40),
                                    backgroundColor: Colors.deepPurple.shade100,
                                    side: BorderSide(
                                      color: Colors.deepPurple.shade400,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()),
                                    );
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    fixedSize: const Size.fromHeight(40),
                                    backgroundColor: Colors.deepPurple.shade100,
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
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
