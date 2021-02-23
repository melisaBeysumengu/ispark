import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ispark/services/park.dart';
import 'package:latlong/latlong.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<Park> locations = [];
  List<Marker> markers = [];

  void updatePark(index) async {
    Park instance = locations[index];
    await instance.getParkInfo();
    Navigator.pushNamed(context, "/home" ,arguments: {
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
  }

  @override
  Widget build(BuildContext context) {

    MapController _mapctl = MapController();

    locations = locations.isNotEmpty ? locations : ModalRoute.of(context).settings.arguments;

    if(locations.isNotEmpty){
      for(int i = 0; i < locations.length; i++){
        if(!(locations[i] == null)){
          markers.add(Marker(anchorPos: AnchorPos.align(AnchorAlign.center),
            height: 80,
            width: 80,
            point: LatLng(double.parse(locations[i].lat),double.parse(locations[i].lng)),
            builder: (ctx) => Icon(Icons.pin_drop, color: Colors.red,),));
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){Navigator.pushNamed(context, "/district");}
        ),
        backgroundColor: Colors.blue[900],
        title: Text(locations[0].district+' İSPARK'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      color: Colors.indigo[200],
                      child: ListTile(
                        onTap: () {
                          updatePark(index);
                        },
                        title: Text(locations[index].parkName),
                      ),
                    ),
                  );
                }
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlutterMap(
                options: new MapOptions(
                  center: LatLng(double.parse(locations[0].lat),double.parse(locations[0].lng)),
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerClusterLayerOptions(
                    maxClusterRadius: 120,
                    size: Size(40, 40),
                    fitBoundsOptions: FitBoundsOptions(
                      padding: EdgeInsets.all(50),
                    ),
                    markers: markers,
                    polygonOptions: PolygonOptions(
                        borderColor: Colors.blueAccent,
                        color: Colors.black12,
                        borderStrokeWidth: 3),
                    builder: (context, markers) {
                      return FloatingActionButton(
                        heroTag: null,
                        child: Text(markers.length.toString()),
                        onPressed: null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
