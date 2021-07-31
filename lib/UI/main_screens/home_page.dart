import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/components/medicine_cards.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:pharmacy_store/models/medicine.dart';
import 'package:pharmacy_store/resources/medicine_resources.dart';

class HomePage extends StatefulWidget implements PreferredSizeWidget {

  static const String id="Home Screen";
  @override
  _HomePageState createState() => _HomePageState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{

  @override
  bool get wantKeepAlive => true;

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getAllMedicineCards(),
                ]
            )
          ],
        ),
      ),
    );
  }
  Widget getAllMedicineCards(){
    return FutureBuilder(
      future: MedicineResources().getAllMedicines() ,
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          print("data : ${snapshot.data}");
          medicines=snapshot.data;
          List<Widget> medicineList=[];
          for(Medicine temp in snapshot.data){
            medicineList.add(MedicineCards(details: temp));
          }
          return Column(
            children: [
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: medicineList,
              ),
            ],
          );
//        return Text(data.toString());
        }
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
