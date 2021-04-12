import 'package:flutter/material.dart';

import '../screen_util.dart';

import 'ribbon.dart';
import 'dart:math' as math;

class OfferRibbon extends StatelessWidget {
  final double percentage;

  OfferRibbon({@required this.percentage});

  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return CustomPaint(
      painter: Ribbon(),
      child: Transform.translate(
        offset: Offset(_screenUtil.setWidth(25), -_screenUtil.setWidth(15)),
        child: Transform.rotate(
          angle: math.pi / 4,
          child: Row(
            children: [
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: _screenUtil.setSp(40),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: _screenUtil.setWidth(10),
              ),
              Text(
                'خصم',
                style: TextStyle(
                  fontSize: _screenUtil.setSp(40),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
