import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_store/components/rounded_button.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:pharmacy_store/UI/main_screens/image_picker.dart';
import 'package:pharmacy_store/models/medicine.dart';


class Vision extends StatefulWidget {
  @override
  _VisionState createState() => _VisionState();
}

class _VisionState extends State<Vision> {
  String string = "TextRecognition";
  File _userImageFile;
  List<ImageLabel> _imageLabels = [];
  List<Barcode> _barCode = [];
  List result = [];
  double threshold=0.6,slider_value=50;
  void _pickedImage(File image) {
    _userImageFile = image;
  }


//recognise_Text
  recogniseText() async {
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(_userImageFile);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(myImage);
    result = [];
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        setState(() {
          result.add(line.text);
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
              Slider(
              value: slider_value,
              min: 0,
              max: 100,
              divisions: 20,
              label: slider_value.round().toString(),
              onChanged: (double value) {
                setState(() {
                  slider_value=value;
                  threshold= (value/100);
                });
                print(threshold);
              },
            ),
                RoundedButton(color: blue,title: "Analyse",onPressed: (){
                  recogniseText();
                }),
                RoundedButton(color: blue,title: "Add to Cart",onPressed: (){
                  recogniseText();
                  for(Medicine i in medicines){
                    String name=i.name.toLowerCase();
                    for(String j in result){
                      j=j.toLowerCase();
                      int count=0;
                      for(int k=0;k<j.length;k++){
                        if(name.contains(j[k]))
                          count++;
                          name.replaceFirst(j[k],"");
                      }
                      if((count/i.name.length)>threshold){
                        user.cartItems.add(i.provider_id);
                        break;
                      }
                    }
                  }
                  Fluttertoast.showToast(
                      msg: "Added to cart",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.greenAccent,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }),
                UserImagePicker(_pickedImage),
                Padding(
                    padding: const EdgeInsets.all(16.0), child: Text(result.toString())),
              ],
            ),
          ),
    );
  }
}