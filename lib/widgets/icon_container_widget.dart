import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconContainer extends StatelessWidget {
  final double size;
  const IconContainer({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.15),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 25,
              // spreadRadius: 5,
              offset: Offset(0, 15))
        ],
      ),
      padding: EdgeInsets.all(size * 0.15),
      child: Center(
          child: SvgPicture.asset(
        'assets/image.svg',
        height: size * 0.6,
        width: size * 0.6,
      )),
    );
  }
}
