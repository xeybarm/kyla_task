import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../animation/drag_painter.dart';
import '../common/style/ui.dart';
import '../pages/menu_page.dart';
import 'circle_button.dart';

class DraggableWidget extends StatefulWidget {
  final int menuItemCount;
  final double buttonSize;
  const DraggableWidget({
    super.key,
    required this.menuItemCount,
    required this.buttonSize,
  });

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget>
    with SingleTickerProviderStateMixin {
  bool _dragged = false;
  bool _dragging = false;
  double _y = 0;

  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.bottomCenter;
  late Animation<Alignment> _animation;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.topCenter,
      ),
    );

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 0,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height / 1.8),
      child: AnimatedAlign(
        alignment: _dragAlignment,
        duration: const Duration(milliseconds: 100),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomPaint(
              painter: DragPainter(_dragging, _dragged, _y, size),
              child: GestureDetector(
                onPanDown: (details) {
                  _controller.stop();
                },
                onPanUpdate: (details) {
                  setState(() {
                    if (details.delta.dx == 0.0 && //no horizontal movement
                        details.delta.dy < 0) // && //only dragging up movement

                    {
                      _dragging = true;
                      _y = details.globalPosition.dy;

                      _dragAlignment += Alignment(
                        details.delta.dx / (size.width / 2),
                        details.delta.dy / (size.height / 2),
                      );
                    }
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    _dragged = true;
                  });
                  _runAnimation(details.velocity.pixelsPerSecond, size);
                },
                child: CircleButton(
                  bgColor: !_dragged ? UI.lightBlue : Colors.white,
                  icon: !_dragged ? CupertinoIcons.add : CupertinoIcons.xmark,
                  iconColor: !_dragged ? Colors.white : UI.lightBlue,
                  buttonSize: widget.buttonSize,
                  onTap: () {
                    setState(() {
                      _dragAlignment = Alignment.bottomCenter;
                      _dragged = false;
                      _dragging = false;
                    });
                  },
                ),
              ),
            ),
            _dragged
                ? MenuPage(
                    itemCount: widget.menuItemCount,
                    buttonSize: widget.buttonSize,
                    onTap: () {
                      setState(() {
                        _dragged = false;
                      });
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
