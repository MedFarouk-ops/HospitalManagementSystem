import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/analyste/widgets/AnalysteCustomListScroller.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalysteHomePage extends StatefulWidget {
  const AnalysteHomePage({Key? key}) : super(key: key);

  @override
  State<AnalysteHomePage> createState() => _AnalysteHomePageState();
}

class _AnalysteHomePageState extends State<AnalysteHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String? token; 

  _setAuthToken() async {
      SharedPreferences s_prefs = await SharedPreferences.getInstance();
      token = s_prefs.getStringList("authTokens")![0];
      setStateIfMounted(() {});
  }   
  
  void setStateIfMounted(f) {
      if (mounted) setState(f);
  }
     

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _setAuthToken();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    
    return Scaffold(

      backgroundColor: thirdAdminColor,
      body: SafeArea(
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .05,
                right: -MediaQuery.of(context).size.width * .1,
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Column( children: [
                    const SizedBox(height: 8),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 1,
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: size.width,
                          alignment: Alignment.topCenter,
                          height: categoryHeight*2.4,
                          child: Column(children: [
                            AnalysteCustomListScroller( token : token),
                            AnalysteThirdListScroller( token : token),
                            AnalysteSecondListScroller( token :token ),
                          ],), 
                      )),
                      // const SizedBox(height: 2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
     ],
    ))));
  }
}