import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/original_button.dart';
import 'dart:ui';
class IntroScreen extends StatelessWidget{ 
  @override
  Widget build(BuildContext context) {
    AssetImage backgroundImage = AssetImage('img/back1.jpg');

    return Scaffold(
      body: Stack(
        children: [
         Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.75), // Adjust the opacity value as needed (0.0 to 1.0)
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(),
                Hero(
                  tag: 'logoAnimation',
                  child: Image.asset(
                    'img/green_irrigate_white_75.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OriginalButton(
                    text: 'Get Started',
                    color: Colors.white,
                    textColor: Color(0xffFFBC75),
                    onPressed: () {
                      Navigator.of(context).pushNamed('login');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
