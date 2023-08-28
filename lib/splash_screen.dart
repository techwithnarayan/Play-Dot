import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:playdot/screens/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    // Add a delay before navigating to the HomePage
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.grey.shade900,
            Colors.grey,
            // Colors.white
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: 
          LottieBuilder.asset('assets/animation.json'),
        ),
      ),
    );
  }
}