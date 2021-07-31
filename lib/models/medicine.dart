import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  String _name;
  String _description;
  String _price;
  String _url;
  String _provider_id;

  Medicine({String name,String url,String provider_id,String price,String description}){
    this._name=name;
    this._price=price;
    this._description=description;
    this._url=url;
    this.provider_id=provider_id;
  }

  Medicine.fromJSON(Map json):
    _name=json['name'],
    _description=json['description'],
    _price=json['price'],
    _url=json['url'];



  String get provider_id => _provider_id;

  set provider_id(String value) {
    _provider_id = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }


  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

// fromDocumentSnapshot(Map<String,dynamic> json) {
  //   name=json['name'];
  //   description=json['description'];
  //   price=json['price'].toString();
  //   url=json['url'];
}