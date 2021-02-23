import 'package:flutter/material.dart';
import 'package:ispark/pages/home.dart';
import 'package:ispark/pages/loading.dart';
import 'package:ispark/pages/chooseLocation.dart';
import 'package:ispark/pages/chooseDistrict.dart';
import 'package:ispark/pages/loadingLocations.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Loading(),
      "/home": (context) => Home(),
      "/district": (context) => ChooseDistrict(),
      "/loading": (context) => LoadingLocations(),
      "/location": (context) => ChooseLocation(),
    },
  ));
}

