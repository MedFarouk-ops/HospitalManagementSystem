import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/widgets/toggle_button_1.dart';

class ParametreSecuritePage extends StatefulWidget {
  const ParametreSecuritePage({Key? key}) : super(key: key);

  @override
  State<ParametreSecuritePage> createState() => _ParametreSecuritePageState();
}

class _ParametreSecuritePageState extends State<ParametreSecuritePage>
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Parametre de securité"),
          backgroundColor: AdminColorSix,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildHeader(
                  title: 'Identification par empreinte digitale',
                  child: ToggleButtons1(),
                ),
              ],
            ),
          ),
        ),
      );
  }
   Widget buildHeader({
    required Widget child,
    required String title,
  }) =>
      Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          child,
        ],
      );
}