import 'package:flutter/material.dart';
import 'package:ispark/services/park.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setInitScreen() async{
    Park instance = Park(parkID: 2381, parkName:"1293 Yavuz Selim Otomatik Otoparkı",lat:"41.0233",lng:"28.9529",capacity:60,emptyCapacity:60,workHours:"24 Saat",parkType:"KAPALI OTOPARK",freeTime:15,district:"FATİH",isOpen:1);
    await instance.getParkInfo();
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "parkID": instance.parkID,
      "parkName": instance.parkName,
      "lat": instance.lat,
      "lng": instance.lng,
      "capacity": instance.capacity,
      "emptyCapacity": instance.emptyCapacity,
      "workHours": instance.workHours,
      "parkType": instance.parkType,
      "freeTime": instance.freeTime,
      "district": instance.district,
      "isOpen": instance.isOpen,
      "updateDate": instance.updateDate,
      "monthlyFee": instance.monthlyFee,
      "tariff": instance.tariff,
      "address": instance.address,
      "areaPolygon": instance.areaPolygon,
    });
  }

  @override
  void initState() {
    super.initState();
    setInitScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 80.0,
          ),
        )
    );
  }
}
