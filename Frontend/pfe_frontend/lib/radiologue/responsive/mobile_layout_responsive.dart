import 'package:flutter/cupertino.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class RadiologueMobileLayout extends StatefulWidget {
  const RadiologueMobileLayout({Key? key}) : super(key: key);

  @override
  State<RadiologueMobileLayout> createState() => _RadiologueMobileLayoutState();
}

class _RadiologueMobileLayoutState extends State<RadiologueMobileLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}