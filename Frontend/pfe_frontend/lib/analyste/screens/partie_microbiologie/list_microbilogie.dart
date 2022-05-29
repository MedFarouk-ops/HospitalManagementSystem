import 'package:flutter/cupertino.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class MicrobiologieListLayout extends StatefulWidget {
  const MicrobiologieListLayout({Key? key}) : super(key: key);

  @override
  State<MicrobiologieListLayout> createState() => _MicrobiologiListeLayoutState();
}

class _MicrobiologiListeLayoutState extends State<MicrobiologieListLayout>
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