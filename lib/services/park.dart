import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class Park {
  int parkID;
  String parkName; // otoparkın adı
  String lat; // otoparkın enlem bilgisi
  String lng; // otoparkın boylam bilgisi
  int capacity; // kapasitesi
  int emptyCapacity; //kalan boş kapasite
  String workHours; //çalışma saatleri
  String parkType; // açık-kapalı-yolüstü otopark
  int freeTime; // ücretsiz bekleme süresi
  String district; // bulunduğu bölge ör: ŞİŞLİ, KADIKÖY...
  int isOpen; // açık mı
  String updateDate; // en son bilgilerin güncellendiği tarih
  String monthlyFee; // aylık ücret bilgisi
  String tariff; // tarifeler ör: 0-1 Saat  : 10,00
  String address; // açık adres bilgisi
  Map areaPolygon; // multipolygon, polygon, linestring, null

  // constructor
  Park({this.parkID,
    this.parkName,
    this.lat,
    this.lng,
    this.capacity,
    this.emptyCapacity,
    this.workHours,
    this.parkType,
    this.freeTime,
    this.district,
    this.isOpen});

  factory Park.fromJson(Map<String, dynamic> json) {
    return Park(parkID: json['parkID'],
      parkName: json['parkName'],
      lat: json['lat'],
      lng: json['lng'],
      capacity: json['capacity'],
      emptyCapacity: json['emptyCapacity'],
      workHours: json['workHours'],
      parkType: json['parkType'],
      freeTime: json['freeTime'],
      district: json['district'],
      isOpen: json['isOpen'],
    );
  }

  Future<void> getParkInfo() async{
    try{
      //make the request
      Response response = await get("https://api.ibb.gov.tr/ispark/ParkDetay?id=$parkID");
      //print(response.body);
      //List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      Map data = jsonDecode(response.body.replaceAll("[", "").replaceAll("]", ""));
      //print(data2["updateDate"]);
      updateDate = data["updateDate"];
      monthlyFee = data["monthlyFee"].toString();
      tariff = data["tariff"];
    }
    catch(e){
      print("caught error: $e");
    }
  }

}