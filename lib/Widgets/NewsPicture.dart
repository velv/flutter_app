import 'package:flutter/material.dart';

// виджет, который рисует картинку
Widget newsPicture(String newsPic) {
  return Stack(
    children: <Widget>[
      Container(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                Colors.white.withOpacity(1.0),
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.4],
            ).createShader(bounds);
          },
          blendMode: BlendMode.screen,
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: NetworkImage(newsPic),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
