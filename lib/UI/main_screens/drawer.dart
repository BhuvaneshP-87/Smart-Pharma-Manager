import 'package:pharmacy_store/UI/login/login_screen.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/UI/secondary_screens/account.dart';
import 'package:pharmacy_store/models/user.dart';

class DrawerPart extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:ListView(
            children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(" ${user.name}",style: heading,),
                  accountEmail: Text(" ${user.detail}",style: subHeading,),
                ),
              ListTile(
                leading: Icon(Icons.person_outline,color: blue,),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Account()));
                },
                title: Text("Account",
                    style: subHeading),
              ),
              ListTile(
                  leading: Icon(Icons.exit_to_app,color: blue,),
                  title: Text("Sign Out",style: subHeading),
                  onTap: () async{
                    loginViewModel.signOut();
                    await loginViewModel.setUserFormStatus(false);
                    await loginViewModel.setLoginStatus(false);
                    user=new User();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
            ],
          ),
    );
  }
}
