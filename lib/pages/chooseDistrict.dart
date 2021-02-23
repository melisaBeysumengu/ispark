import 'package:flutter/material.dart';

class ChooseDistrict extends StatefulWidget {
  @override
  _ChooseDistrictState createState() => _ChooseDistrictState();
}

class _ChooseDistrictState extends State<ChooseDistrict> {

  List<String> districts = ["ARNAVUTKÖY", "ATAŞEHİR", "AVCILAR", "BAĞCILAR", "BAHÇELİEVLER", "BAKIRKÖY", "BAŞAKŞEHİR", "BAYRAMPAŞA", "BEŞİKTAŞ", "BEYKOZ", "BEYLİKDÜZÜ", "BEYOĞLU", "BÜYÜKÇEKMECE", "ESENLER", "EYÜP", "FATİH", "GAZİOSMANPAŞA", "GÜNGÖREN", "KADIKÖY", "KAĞITHANE", "KARTAL", "KÜÇÜKÇEKMECE", "MALTEPE", "PENDİK", "SARIYER", "SİLİVRİ", "SULTANBEYLİ", "SULTANGAZİ", "ŞİŞLİ", "TUZLA", "ÜMRANİYE", "ÜSKÜDAR", "ZEYTİNBURNU"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[900],
        title: Text('İlçeler'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GridView.count(
        childAspectRatio: 2,
        crossAxisCount: 2 ,
        children: List.generate(districts.length,(index){
          return Container(
            child: Card(
              color: Colors.indigo,
              child: InkResponse(
                child: Center(
                  child: Text(
                    districts[index],
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        color: Colors.white
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, "/loading",arguments: districts[index]);
                },
              ),
            ),
          );
        }),
      )
    );
  }
}
