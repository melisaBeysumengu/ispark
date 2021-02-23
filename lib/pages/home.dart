import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  MapController _mapctl = MapController();

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.indigo,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Tarife'),
        icon: FaIcon(FontAwesomeIcons.liraSign, size: 15,),
        backgroundColor: Colors.orange,
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctxt) => new AlertDialog(
                backgroundColor: Colors.indigo,
                title: Text("Tarife", style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),
                content: Text(data["tariff"].toString().replaceAll(";", "\n"), style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              )
          );
        }),
      body: SafeArea(
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data["district"]+": "+data["parkName"],
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    //SizedBox(height: 10,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlutterMap(
                          mapController: _mapctl,
                          options: MapOptions(
                            center: LatLng(double.parse(data["lat"]), double.parse(data["lng"])),
                            zoom: 17.0,
                          ),
                          layers: [
                            TileLayerOptions(
                                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c']
                            ),
                            MarkerLayerOptions(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: LatLng(double.parse(data["lat"]), double.parse(data["lng"])),
                                  builder: (ctx) =>
                                      Container(
                                        child: Icon(Icons.location_on, color: Colors.red, size: 30),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () async{
                          dynamic result = await Navigator.pushNamed(context, "/district");
                          setState(() {
                            data = {
                              "parkID": result["parkID"],
                              "parkName": result["parkName"],
                              "lat": result["lat"],
                              "lng": result["lng"],
                              "capacity": result["capacity"],
                              "emptyCapacity": result["emptyCapacity"],
                              "workHours": result["workHours"],
                              "parkType": result["parkType"],
                              "freeTime": result["freeTime"],
                              "district": result["district"],
                              "isOpen": result["isOpen"],
                              "updateDate": result["updateDate"],
                              "monthlyFee": result["monthlyFee"],
                              "tariff": result["tariff"],
                              "address": result["address"],
                              "areaPolygon": result["areaPolygon"],
                            };
                            _mapctl.onReady.then((result) {
                              _mapctl.move(LatLng(double.parse(data["lat"]), double.parse(data["lng"])), 17.0);
                            });

                            });
                        },
                        icon: Icon(
                          Icons.edit_location,
                          color: Colors.grey[300],
                        ),
                        label: Text(
                          "Diğer Lokasyonlara Gözat",
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        )
                    ),
                    Text(
                      "İlk "+data["freeTime"].toString()+" dakika ücretsiz",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      "Doluluk: "+(data["capacity"]-data["emptyCapacity"]).toString()+"/"+data["capacity"].toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      data["workHours"]+" açık",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      data["parkType"],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      "Son güncelleme: " +data["updateDate"],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      "Aylık Ücret: ₺"+data["monthlyFee"],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 25,),
                  ],
                ),
              ),
            ),
          )
      ),

    );
  }
}
