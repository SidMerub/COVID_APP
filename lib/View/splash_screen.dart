import 'dart:async';


import 'package:covid_app/View/world-stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

   late final AnimationController _controller =AnimationController(
       duration: const Duration(seconds: 3),
       vsync: this)..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
      ()=> Navigator.push(context, MaterialPageRoute(builder:(context) => WORLDSTATS())));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
             AnimatedBuilder(animation: _controller,
                 child: Container(
                   width: 200,
                   height: 200,
                   child: const Center(child: Image(image: AssetImage('assets/virus.jpg'))),
                 ),
                 builder:(BuildContext context, Widget? child){
                 return Transform.rotate(angle: _controller.value* 2.0* math.pi,
                 child: child,);
                 }
             ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Covid Tracker\nTracker App' , style: TextStyle(
                fontWeight: FontWeight.bold ,fontSize: 25
              ),),
            )
          ],
        ),
      ),
    );
  }
}
