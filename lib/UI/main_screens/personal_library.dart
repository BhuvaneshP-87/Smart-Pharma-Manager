import 'package:pharmacy_store/components/medicine_cards.dart';
import 'package:pharmacy_store/components/rounded_button.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/models/medicine.dart';
import 'package:pharmacy_store/resources/medicine_resources.dart';
import 'package:pharmacy_store/resources/user_resources.dart';

class PersonalLibrary extends StatefulWidget implements PreferredSizeWidget {

  static const String id="Personal Library";
  @override
  _PersonalLibraryState createState() => _PersonalLibraryState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _PersonalLibraryState extends State<PersonalLibrary>{


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    UserResouces().updateUserDocumentInCollection(documentData: user).then(
            (value) {
          user.fromDocumentSnapshot(value);
        }
    );
    super.dispose();
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${user.name}'s cart,",style: heading,),
                ),
                (user.favourite.length==0)?Container():
                cart(medicine_list: user.favourite),
              ]
            ),
            RoundedButton(color: blue, title: "Clear cart",onPressed: (){
              setState(() {
                user.favourite=[];
              });
            })
          ],
        ),
      ),
    );
  }

  Widget cart({List medicine_list}){
    print(medicine_list);
    return FutureBuilder(
      future: MedicineResources().getMedicinesfromID(documentIDs: medicine_list) ,
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          print("data : ${snapshot.data}");
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
