import 'package:pharmacy_store/models/medicine.dart';
import 'package:pharmacy_store/models/user.dart';
import 'package:pharmacy_store/BLoC(ViewModel)/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

FirebaseUser loggedInUser;
LoginViewModel loginViewModel=new LoginViewModel();
List<Medicine> medicines=[];
//LanguageViewModel languageObject=new LanguageViewModel();
User user=new User();
Color blue=Color(0xff59bfff);
Color white=Color(0xffffffff);

TextStyle heading= GoogleFonts.lato(
color: Colors.black87,
fontSize: 20,
fontWeight: FontWeight.bold);

TextStyle description=GoogleFonts.lato(
  color: Colors.black87,
  fontSize: 12,);

TextStyle subHeading=GoogleFonts.lato(
  color: Colors.black87,
  fontStyle: FontStyle.italic,
  fontSize: 15,);
