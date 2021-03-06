import 'package:pharmacy_store/resources/local_storage.dart';
import 'package:pharmacy_store/resources/user_resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pharmacy_store/constants.dart';


//SplashScreenPage UI
class SplashScreen extends StatefulWidget {
  static const String id="Splash Screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  LocalStorage method = new LocalStorage();


  getUserDetails()async{
    try{
      loggedInUser=await FirebaseAuth.instance.currentUser();
      String search=(loggedInUser.phoneNumber=="" ||loggedInUser.phoneNumber==null)?loggedInUser.email:loggedInUser.phoneNumber;
      print(loggedInUser);
      user.fromDocumentSnapshot(await UserResouces().searchUser(search: search));
    }catch(e){
      print(e);
    }
  }
  void initState() {
    getUserDetails().then((value){
      Timer(
          Duration(seconds: 2),
              () => loginViewModel.checkScreenStatus().then((value) => {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => value))
          }));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context){

    return SafeArea(
      child: Scaffold(
        body:Center(
          child: Container(
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splashscreen.png",),
              fit: BoxFit.cover,
            ),
          ),
          ),
        ),
      ),
    );
  }
}
