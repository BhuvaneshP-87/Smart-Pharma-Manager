import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_store/constants.dart';
import 'package:pharmacy_store/models/medicine.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicineResources {

  String medicinePath='Medicine';
  final _firestore = Firestore.instance;

  Future<List<Medicine>> getAllMedicines() async{
    try {
      List<Medicine> medicinedata=[];
      final data = await _firestore.collection(medicinePath).getDocuments();
      print(data.documents.length);
      for(var document in data.documents){
        Medicine temp= Medicine.fromJSON(document.data);
        temp.provider_id=document.documentID;
        medicinedata.add(temp);
        print(temp);
      }
      print(medicinedata);
      return medicinedata;
    }
    catch(error){
      return error;
    }
  }

  Future<List<Medicine>> getMedicinesfromID({List documentIDs}) async{
    try {
      List<Medicine> medicinedata=[];
      for(var id in documentIDs){
        final data = await _firestore.collection(medicinePath)
            .document(id)
            .get();
        print(data.data);
        Medicine temp= Medicine.fromJSON(data.data);
        temp.provider_id=data.documentID;
        print(temp);
        medicinedata.add(temp);
      }
      print(medicinedata);
      return medicinedata;
    }
    catch(error){
      return error;
    }
  }

}