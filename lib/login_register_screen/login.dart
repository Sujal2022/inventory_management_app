import 'package:flutter/material.dart';
import 'package:inventory_management_app/login_register_screen/registration.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../database/dbhelper.dart';
import '../homescreens.dart';
import '../widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;
  final dbHelper = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  void checklogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool newuser = (sharedPreferences.getBool('mylogin') ?? false);

    if (newuser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreens()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        SizedBox(height: 9),
        CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/img_2.png'), // Image path
        ),
        SizedBox(height: 20),
        Text(
          "Welcome To",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          "Inventory Management App",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
        ),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          CustomTextfields(
            controller: nameController,
            labettxt: 'Enter Your Email',
            hinttxt: 'Email',
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            }, // Optional icon
          ),
          CustomTextfields(
            controller: passController,
            labettxt: 'Enter Your Password',
            hinttxt: 'Password',
            visibility: true, // Hide the password
            prefixIcon: Icons.lock,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              }, // Optional icon
          ),
          const SizedBox(height: 10),

          ElevatedButton(
              onPressed: () async {
                if (formGlobalKey.currentState!.validate()) {
                  String email = nameController.text.trim();
                  String password = passController.text.trim();

                  // Check user credentials in SQLite
                  Map<String, dynamic>? user = await dbHelper.getUser(email);

                  if (user != null && user['password'] == password) {
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setBool('mylogin', true);
                    sharedPreferences.setString('myemail', email);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreens()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Invalid email or password!'),
                    ));
                  }
                }
              },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.purple,
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }
}
