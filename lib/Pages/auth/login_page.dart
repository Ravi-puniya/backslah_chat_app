import 'package:backslah_chat_app/Pages/auth/signup_page.dart';
import 'package:backslah_chat_app/Pages/homepage.dart';
import 'package:backslah_chat_app/services/authservice.dart';

import 'package:backslah_chat_app/widget/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Groupie',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Login now to see what they are talking',
                style: TextStyle(fontSize: 15),
              ),
              Image.asset('assets/login.png'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                  print(email);
                },
                decoration: textinputdecoration.copyWith(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xFFee7b64),
                    ),
                    label: const Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xFFee7b64),
                      ),
                    )),
                validator: (val) {
                  return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!)
                      ? null
                      : "Please enter a valid email";
                },
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                  print(password);
                },
                obscureText: true,
                decoration: textinputdecoration.copyWith(
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Color(0xFFee7b64),
                    ),
                    label: const Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFFee7b64),
                      ),
                    )),
                validator: (value) {
                  if (value == null) {
                    return 'Enter a valid Password';
                  } else if (value.length < 6) {
                    return 'Enter a password max length 7';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFee7b64),
                  ),
                  child: _loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont Have an Account ?',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        nextscreen(context, SignUpPage());
                      },
                      child: Text(
                        'Registor Now',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value != null) {
          //QuerySnapshot snapshot =   await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);

          setState(() {
            _loading = false;
          });
          nextScreenReplace(context, HomeScreen());
        }
      });
    }
  }
}
