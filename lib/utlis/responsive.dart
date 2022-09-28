import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  double? _width, _height, _diagonal;
  bool? _isTablet;

  double? get width => _width;
  double? get height => _height;
  double? get diagonal => _diagonal;
  bool? get isTablet => _isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(math.pow(_width!, 2) + math.pow(_height!, 2));

    _isTablet = size.shortestSide >= 600;
  }
//ANCHO
  double wp(double percent) {
    return _width! * percent / 100;
  }

  //LARGO
  double hp(double percent) {
    return _height! * percent / 100;
  }

//DIAGONAL PARA TEXTOS
  double dp(double percent) {
    return _diagonal! * percent / 100;
  }
}
