import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ispark/services/park.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingLocations extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingLocations> {

  String selectedDistrict = "";

  List<Park> locations;

  Future loadingLocations() async {
    try {
      selectedDistrict = await (selectedDistrict.isNotEmpty ? selectedDistrict : ModalRoute.of(context).settings.arguments);
      //make the request
      Response response = await get("https://api.ibb.gov.tr/ispark/Park");
      // Use jsonDecode function to decode the JSON string
      // I assume the JSON format is correct
      final json = jsonDecode(response.body);
      List<Park> data =[];
      // The JSON data is an array, so the decoded json is a list.
      // We will do the loop through this list to parse objects.
      if (json != null) {
        json.forEach((element) {
          final park = Park.fromJson(element);
          if(park.district == selectedDistrict){
            data.add(park);
          }
          //print(park.parkName);
        });
      }
      setState(() {
        locations = data;
      });

      await Navigator.pushNamed(context, "/location",arguments: locations);

    }
    catch(e){
      print("caught error: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadingLocations();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 80.0,
          ),
        )
    );
  }
}
