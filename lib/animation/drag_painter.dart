import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../common/style/ui.dart';

class DragPainter extends CustomPainter {
  final double y;
  final Size sizeScreen;
  final bool dragging;
  final bool dragged;
  DragPainter(this.dragging, this.dragged, this.y, this.sizeScreen);

  @override
  void paint(Canvas canvas, Size size) {
    if (dragging) {
      canvas.drawPath(
        Path()
          ..addArc(
              Rect.fromPoints(
                Offset(size.width - 10, (sizeScreen.height - y) / 2),
                Offset(sizeScreen.width, (y - sizeScreen.height) / 2),
              ),
              0,
              math.pi)
          ..addArc(
              Rect.fromPoints(
                Offset(10, (sizeScreen.height - y) / 2),
                Offset(-sizeScreen.width, (y - sizeScreen.height) / 2),
              ),
              0,
              math.pi)
          ..addRect(Rect.fromLTRB(
            -sizeScreen.width,
            -sizeScreen.height,
            sizeScreen.width,
            25,
          ))
          ..close(),
        Paint()
          ..color = UI.lightBlue.withOpacity(y > 500 ? 0.9 : 1)
          ..style = PaintingStyle.fill,
      );

      //adds white border around plus icon
      if (y > 600) {
        canvas.drawPath(
          Path()
            ..addRRect(RRect.fromLTRBR(
                -1, -1, 56, sizeScreen.height, const Radius.circular(30)))
            ..close(),
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill,
        );
      }
    }

    if (dragged) {
      canvas.drawPaint(Paint()..color = UI.lightBlue);
      canvas.drawColor(
        UI.lightBlue,
        BlendMode.srcIn,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DragPainter oldDelegate) {
    return false;
  }
}
