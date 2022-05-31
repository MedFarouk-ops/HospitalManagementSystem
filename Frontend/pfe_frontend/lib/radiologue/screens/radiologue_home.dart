import 'package:flutter/cupertino.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class RadiologueHomePage extends StatefulWidget {
  const RadiologueHomePage({Key? key}) : super(key: key);

  @override
  State<RadiologueHomePage> createState() => _RadiologueHomePageState();
}

class _RadiologueHomePageState extends State<RadiologueHomePage>
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
