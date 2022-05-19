import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/models/user.dart';
import 'package:pfe_frontend/authentication/screens/Home_screen.dart';
import 'package:pfe_frontend/authentication/context/authcontext.dart';
import 'package:pfe_frontend/authentication/screens/register_screen.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/authentication/utils/text_field_input.dart';
import 'package:pfe_frontend/authentication/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({ Key? key }) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  late SharedPreferences s_prefs;
  bool? _isAuth = false ;
  bool isAuthenticated = false ;
  bool _isLoading = false ;
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    _checkAuth();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
  }


  _checkAuth() async {
    s_prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAuth = s_prefs.getBool("isAuthenticated");
    });
  }
  

  void setStateIfMounted(f) {
  if (mounted) setState(f);
  }

  void loginUser() async {
           setStateIfMounted(() {
              _isLoading = true;
            });
            User? authuser = await AuthContext().SignIn(
                email: _emailField.text,
                password: _passwordField.text,
                );
            _user = authuser ;
            setStateIfMounted(() {
              _isLoading = false;
            });

            if(authuser.email == ""){
              showSnackBar("please check your credentials", context);
              s_prefs.setBool("isAuthenticated", false); 
            }
            else{
               if (mounted){
               s_prefs = await SharedPreferences.getInstance();
               s_prefs.setBool("isAuthenticated", true); 
               Navigator.of(context)
                  .pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen()
                      )
                  );
               }
            }
  }
  void navigateToSignup(){
    Navigator.of(context)
    .push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen()
        )
    );
  }
  // void navigateHome(User ){
  //   Navigator.of(context)
  //   .push(
  //     MaterialPageRoute(
  //       builder: (context) => const HomeScreen(user: buser,)
  //       )
  //   );
  // }

@override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container() , flex: 1,),
              // svg Image
              const SizedBox(height: 64,),
              // textfield for email 
              TextFieldInput(hintText: "Email",
               textEditingController: _emailField,
                textInputType: TextInputType.emailAddress
              ),
              const SizedBox(
                height: 25,
              ),
              // textfield for password
              TextFieldInput(
                hintText: "Password",
                textEditingController: _passwordField,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 40,
              ),
              // login button
              InkWell(
              onTap: loginUser,
              child : Container(
                child: _isLoading ? Center(child: CircularProgressIndicator(
                  color: primaryColor,
                ),)
                 : const Text("Log in"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical : 12,),
                decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                color: blueColor
                ),
              ),),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container() , flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                  onTap: navigateToSignup,
                  child : Container(
                    child: Text("Sign up", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                       ),),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  ),
                ],)
              // Transitioning to sign up
            ],
          ),
        ),
      ),
    ) ;
    }
  }