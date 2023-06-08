import 'package:flutter/material.dart';
import 'package:kyla_task/common/style/ui.dart';
import 'package:kyla_task/widgets/bottom_nav_bar.dart';
import 'package:kyla_task/widgets/draggable_widget.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: const [
          Center(
            child: Text(
              'Events',
              style: UI.textStyle,
            ),
          ),
          BottomNavBar(),
          DraggableWidget(
            menuItemCount: 4,
            buttonSize: 55,
          ),
        ],
      ),
    );
  }
}
