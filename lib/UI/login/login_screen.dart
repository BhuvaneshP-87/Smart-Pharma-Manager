import 'package:pharmacy_store/UI/login/user_form.dart';
import 'package:pharmacy_store/UI/main_screens/landing_page.dart';
import 'package:pharmacy_store/components/rounded_button.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseUser _user;

  @override
  void initState() {
    _user=null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset("assets/logo.png",scale: 2,),
                  SizedBox(height: 180,),
                  _user==null?RoundedButton(
                    title: "Google",
                    color: Colors.redAccent,
                    onPressed: googleLogin,
                  ):Container(),
                  _user!=null?RoundedButton(
                    title: "Get Started",
                    color: blue,
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Userform()));
                    },
                  ):Container(),
                ],
              ),
            )
        ),
      ),
    );
  }


  void googleLogin() {
    if (_user == null) {
      FirebaseAuthUi.instance().launchAuth([
        AuthProvider.google(),
      ]).then((firebaseUser) async{
        await loginViewModel.setLoginStatus(true);
        setState(() {

          _user = firebaseUser;
        });
      }).catchError((error) {
        print(error);
      });
    }
  }
  void phoneLogin() {
    if (_user == null) {
      FirebaseAuthUi.instance().launchAuth([
        AuthProvider.phone(),
      ]).then((firebaseUser) async{
        await loginViewModel.setLoginStatus(true);
        setState(() {
          _user = firebaseUser;
        });
      }).catchError((error) {
        print(error);
      });
    }
  }
}

