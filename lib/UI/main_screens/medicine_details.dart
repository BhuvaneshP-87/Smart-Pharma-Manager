import 'package:pharmacy_store/components/rounded_button.dart';
import 'package:pharmacy_store/models/medicine.dart';
import 'package:pharmacy_store/resources/user_resources.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BookDetails extends StatefulWidget {

  static const String id='BookingScreen';
  BookDetails({this.medicine});
  final  Medicine medicine;

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {

  Medicine temp;

  @override
  void initState() {
    temp=widget.medicine;
    super.initState();
  }
  @override
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
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: (){
                final RenderBox box = context.findRenderObject();
                    Share.share("Hey check out this book \n ${temp.name} \n ${temp.description} \n",
                        subject: "${temp.name} \n ${temp.description} \n}",
                        sharePositionOrigin:
                        box.localToGlobal(Offset.zero) &
                        box.size);
                  },
            ),
          ],
        ),
        body:  ListView(
          children: <Widget>[
            Padding(
              padding:EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          flex:1,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.network(temp.url),
                          )),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${temp.name}",
                                style: GoogleFonts.lato(
                                    textStyle: Theme.of(context).textTheme.display2,
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text("Rs ${temp.price}",
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.display2,
                                  color: Colors.black87,
                                  fontSize: 30,
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  RoundedButton(
                    color: blue,
                    title: "Add to cart",
                    onPressed: ()async{
                      user.favourite.add(temp.provider_id);
                      Fluttertoast.showToast(
                          msg: "Added to cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    },
                  ),
                  Text(
                    "Description",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.display2,
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${temp.description}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.display2,
                        color: Colors.black87,
                        fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

}
