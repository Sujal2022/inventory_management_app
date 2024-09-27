import 'package:flutter/material.dart';
import '../database/dbhelper.dart';
import '../widgets/textfield.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  final dbHelper = DbHelper.instance;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 60.0),
                      const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Create your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      CustomTextfields(
                        controller: name,
                        labettxt: 'Name',
                        hinttxt: 'Full Name',
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      CustomTextfields(
                        controller: email,
                        labettxt: 'Email',
                        hinttxt: 'Email',
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      CustomTextfields(

                        controller: phone,
                        labettxt: 'Phone Number',
                        hinttxt: 'Phone Number',
                        prefixIcon: Icons.phone,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Please enter only numbers';
                          }
                          if (value.length != 10) {
                            return 'please enter 10 number';
                          }
                          return null;
                        },

                      ),
                      // Password field
                      CustomTextfields(
                        controller: password,
                        labettxt: 'Password',
                        hinttxt: 'Password',
                        prefixIcon: Icons.password,
                        visibility: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          /*if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }*/
                          return null;
                        },
                      ),
                      // Confirm password field
                      CustomTextfields(
                        controller: cpassword,
                        labettxt: 'Confirm Password',
                        hinttxt: 'Confirm Password',
                        prefixIcon: Icons.password,
                        visibility: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          _insert();
                        }
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.purple),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _insert() async {
    Map<String, dynamic> row = {
      DbHelper.columnName: name.text,
      DbHelper.columnEmail: email.text,
      DbHelper.columnPhone: phone.text,
      DbHelper.columnPassword: password.text,
      DbHelper.columnCPassword: password.text,
    };

    print("Inserting row: $row");

    final id = await dbHelper.insert(row);
    print("Insert result: $id");

    if (id != null && id > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful!")),
      );

      name.clear();
      email.clear();
      phone.clear();
      password.clear();
      cpassword.clear();

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Failed! Please try again.")),
      );
    }
  }
}
