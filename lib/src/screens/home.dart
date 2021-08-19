import 'package:animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
        CurvedAnimation(parent: boxController, curve: Curves.easeInOut));
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -82.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: [
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRighttFlap()
              ],
            ),
          )),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (BuildContext context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0,
          left: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: boxAnimation.value,
              child: child,
              alignment: Alignment.topLeft,
            );
          },
          child: Container(height: 10, width: 125, color: Colors.brown)),
    );
  }

  Widget buildRighttFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: boxAnimation.value * -1,
              child: child,
              alignment: Alignment.topRight,
            );
          },
          child: Container(height: 10, width: 125, color: Colors.brown)),
    );
  }
}
