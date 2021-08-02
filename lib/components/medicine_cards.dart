import 'package:pharmacy_store/UI/main_screens/medicine_details.dart';
import 'package:pharmacy_store/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineCards extends StatelessWidget {
  MedicineCards({@required this.details});
  Medicine  details;

  @override
  Widget build(BuildContext context) {
    
    return MaterialButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetails(medicine: details)));
      },
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              child: Align(
                widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Image.network(details.url,height: 120,width: 120,))),
          Text(" ${details.name}",style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.display2,
              color: Colors.black87,
              fontSize: 12,
            fontWeight: FontWeight.bold
                ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,),
          Text(
            "Rs ${details.price}",
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.display2,
                color: Colors.black87,
                fontSize: 10,
                fontStyle: FontStyle.italic),
            overflow: TextOverflow.ellipsis,)
        ],),
    );
  }
}
