import 'package:cloud_firestore/cloud_firestore.dart';

String TarihCevir(Timestamp timestamp){
  DateTime dateTime=timestamp.toDate();

  String yil=dateTime.year.toString();

  String ay=dateTime.month.toString();

  String gun=dateTime.day.toString();

  String tarihCevir="$gun/$ay$yil";

  return tarihCevir;
}