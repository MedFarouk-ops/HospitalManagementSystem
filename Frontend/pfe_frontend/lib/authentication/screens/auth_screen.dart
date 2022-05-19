import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/screens/Home_screen.dart';
import 'package:pfe_frontend/authentication/screens/login_screen.dart';
import 'package:pfe_frontend/authentication/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {
  late SharedPreferences s_prefs;
  bool? _isAuth = false ;

  
  _checkAuth() async {
    s_prefs = await SharedPreferences.getInstance();
    if(s_prefs.getBool("isAuthenticated") == null){
      s_prefs.setBool("isAuthenticated", false); 
    }
    setState(() {
      _isAuth = s_prefs.getBool("isAuthenticated");
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkAuth();
  }

  // *********************************************//

  // empêcher l'utilisateur de revenir en arriere : 

  ModalRoute<dynamic>? _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route?.removeScopedWillPopCallback(_onWillPop);
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(_onWillPop);
  }

  @override
  void dispose() {
    _route?.removeScopedWillPopCallback(_onWillPop);
    super.dispose();
  }
  
  Future<bool> _onWillPop() => Future.value(false);

  // ************************************************ // 

  
  
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Center(),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.lightBlue,
                Colors.blue,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff42a5f5),
                        offset: Offset(
                          2,
                          4,
                        ),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(
                        0xFF0389F6,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}