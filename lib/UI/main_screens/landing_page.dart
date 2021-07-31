import 'dart:io';

import 'package:pharmacy_store/UI/main_screens/drawer.dart';
import 'package:pharmacy_store/UI/main_screens/home_page.dart';
import 'package:pharmacy_store/UI/main_screens/personal_library.dart';
import 'package:pharmacy_store/UI/main_screens/vision.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:flutter/material.dart';
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {

  TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Vision(),
    HomePage(),
    PersonalLibrary(),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this,initialIndex: 1);
    super.initState();
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            MaterialButton(
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pharmacy Store",
                      style:heading,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        drawer: DrawerPart(),
        body: TabBarView(
          children: _widgetOptions,
          controller: _tabController,
        ),
        bottomNavigationBar: TabBar(
          unselectedLabelColor: Colors.black87,
          labelColor: blue,
          tabs: [
            Tab(icon: Icon(Icons.camera),text: "Scan",),
            Tab(icon: Icon(Icons.home),text:"Home"),
            Tab(icon: Icon(Icons.shopping_cart),text: "Cart",),
        ],
          controller: _tabController,
        )
      ),
    );
  }
}

