import 'package:flutter/cupertino.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class CreerBilan extends StatefulWidget {
  const CreerBilan({Key? key}) : super(key: key);

  @override
  State<CreerBilan> createState() => _CreerBilanState();
}

class _CreerBilanState extends State<CreerBilan>
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