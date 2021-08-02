import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_store/components/medicine_cards.dart';
import 'package:pharmacy_store/components/rounded_button.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/models/medicine.dart';
import 'package:pharmacy_store/resources/medicine_resources.dart';
import 'package:pharmacy_store/resources/user_resources.dart';

class CartScreen extends StatefulWidget implements PreferredSizeWidget {

  static const String id="Personal Library";
  @override
  _CartScreenState createState() => _CartScreenState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _CartScreenState extends State<CartScreen>{


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
        child: user.cartItems.isEmpty?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Your cart feels lonely!",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.notoSans(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: blue,
                ),
              ),
            ),
          ],
        ):ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${user.name}'s cart,",style: heading,),
            ),
            (user.cartItems.length==0)?Container():
            cart(medicine_list: user.cartItems),
            RoundedButton(color: blue, title: "Clear cart",onPressed: (){
              setState(() {
                user.cartItems=[];
              });
            }),
            RoundedButton(color: blue, title: "Checkout",onPressed: (){
              setState(() {
                user.cartItems=[];
              });
              showDialog(
                context: context,
                // ignore: deprecated_member_use
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  content: StatefulBuilder(builder: (context, snapshot) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.check_circle_outline,
                            size: 96,
                            color: Colors.green,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Your order is successfully placed",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            }),
            ]
          ,
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
