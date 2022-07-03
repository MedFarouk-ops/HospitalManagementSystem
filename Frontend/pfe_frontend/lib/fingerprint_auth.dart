import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/screens/home_screen.dart';
import 'package:pfe_frontend/authentication/utils/utils.dart';

class FingerprintAuth extends StatefulWidget {
  const FingerprintAuth({Key? key}) : super(key: key);

  @override
  _FingerprintAuthState createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool _canCheckBiometric = false;
  late List<BiometricType> _availableBiometric;


  _deconnecter(){
    AuthContext().logoutUser(context);
  }



  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your finger to authenticate",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      showSnackBar("Cette appareil ne supporte pas l'empreinte digitale", context);
      print(e);
    }

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
      print(authorized);
    });
    if(authenticated){
      _navigateToHomeScreen();
    }
  }

  _navigateToHomeScreen(){
     Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen()
        )
    );
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Fingerprint Auth")),
      backgroundColor: Color(0xFF3C3E52),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/fingerprint.png",
                    width: 120.0,
                  ),
                  Text(
                    "Auth. avec empreintes digitales ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Authentifiez-vous en utilisant votre empreinte digitale",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, height: 1.5),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: _authenticate,
                      elevation: 0.0,
                      color: Color(0xFF04A5ED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 14.0),
                        child: 
                        Text(
                          "S'identifier",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: _deconnecter,
                      elevation: 0.0,
                      color: Color(0xFF04A5ED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 14.0),
                        child: 
                        Text(
                          "Déconnexion",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}