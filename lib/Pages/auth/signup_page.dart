import 'package:backslah_chat_app/Pages/homepage.dart';
import 'package:backslah_chat_app/helper/helper_function.dart';
import 'package:backslah_chat_app/services/authservice.dart';
import 'package:flutter/material.dart';

import '../../widget/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formkey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  bool _loading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
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
                'Create your account now to chat and explore',
                style: TextStyle(fontSize: 15),
              ),
              Image.asset('assets/register.png'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: textinputdecoration.copyWith(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xFFee7b64),
                    ),
                    label: const Text(
                      'Full Name',
                      style: TextStyle(
                        color: Color(0xFFee7b64),
                      ),
                    )),
                validator: (val) {
                  if (val != null) {
                    return null;
                  } else {
                    return "Enter a valid Name";
                  }
                },
              ),
              SizedBox(
                height: 14,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
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
                  register();
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
                            'Register',
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
                    'Alreday Have Account ?',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Log in',
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

  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      await authService
          .registerUserWithemailandPassword(name, email, password)
          .then((value) async {
        setState(() {
          _loading = false;
        });

        if (value == true) {
          await HelperFunctrion.saveUserLoggedInstatus(true);
          await HelperFunctrion.saveUseremail(email);
          await HelperFunctrion.saveUsersName(name);
          setState(() {
            _loading = false;
          });
          nextScreenReplace(context, HomeScreen());
        } else {
          showSnackbar(context, value, Colors.red);
          setState(() {
            _loading = false;
          });
        }
      });
    }
  }
}
