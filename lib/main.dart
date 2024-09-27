import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/widgets/textfield.dart';
import 'package:lottie/lottie.dart';

import 'extra.dart';
import 'login_register_screen/login.dart';



void main()
{
 // runApp(MaterialApp(home: HomePage1(),));
  runApp(MaterialApp(home: SplashScreen(),));
}


class SplashScreen extends StatefulWidget
{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{

  @override
  void initState()
  {
    // TODO: implement initState
    // super.initState();
    Timer(Duration(seconds: 3), ()
    {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()));
    });

  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      body: Center
        (
        //child:Image.network("https://yt3.googleusercontent.com/tWt6Z524G85N6RuHk2IHy05wso5CZ3YA2uK7Fzs4UO2i815uO_66j2s4aayp0eIj0jSAmCna1w=s900-c-k-c0x00ffffff-no-rj")
        child:Lottie.asset('assets/animation.json'),

      ),
    );
  }
}




