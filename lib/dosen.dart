import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sqs/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String g = '1462000182';

class Dosen extends StatefulWidget {
  
  @override
  _DosenState createState() => _DosenState();
}

class _DosenState extends State<Dosen> {
  
  TextEditingController nbi = TextEditingController();

  TabController tabController;


  @override
  void initState() {
    // TODO: implement initState

    getdata().then((value) => datas=value);
    super.initState();
  }

      List<Dat> fromJson(String strJson) {
        final data = jsonDecode(strJson);
        return List<Dat>.from(data.map((i) => Dat.fromMap(i))).toList();
      }

      List<Dat> datas = [];

      Future<List<Dat>> getdata() async{
          List<Dat> list = [];
          final response = await http.post(Uri.parse("http://192.168.6.100:81/flutter/showchart.php"),body: {"nbi": '$g'});
          list = fromJson(response.body);
          return list;
      }

      
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Dosen Page"),
            backgroundColor: Color.fromARGB(255, 184, 23, 23),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                },
                icon: Icon(Icons.lock_open),
              )
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      Container(height: 10,),
                      new TextField(
                        controller: nbi,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                          labelText: 'NBI', hintText: 'NBI',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          child: new Text(
                            "Tampil",
                            style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),
                          ),
                          onPressed: () {
                            setState(() {
                              g = nbi.text;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: Color.fromARGB(255, 173, 38, 38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        ),
                      ),
                    ],
                  ),
                  
                  Container(height: 30,),
                  
                  Container(
                    padding: EdgeInsets.only(left: 65,top: 5),
                    child: Text("Diagram Perbandingan Nilai",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                    ),
                  ),

                  Container(height: 30,),
                
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    
                    legend: Legend(isVisible: true),

                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<Dat, String>>[
                      ColumnSeries<Dat, String>(
                          dataSource: datas,
                          xValueMapper: (Dat e, _) => e.nama_mk,
                          yValueMapper: (Dat e, _) => e.eas,
                          name: 'EAS',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true)),
                      ColumnSeries<Dat, String>(
                          dataSource: datas,
                          xValueMapper: (Dat e, _) => e.nama_mk,
                          yValueMapper: (Dat e, _) => e.ets,
                          name: 'ETS',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true)),
                    ]),

                     Container(height: 20,),

                  SfCircularChart(
                    
                    title: ChartTitle(text: 'Chart Nilai EAS',textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    
                    legend: Legend(isVisible: true),
                   
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CircularSeries<Dat, String>>[
                      PieSeries<Dat, String>(
                          dataSource: datas,
                          xValueMapper: (Dat e, _) => e.nama_mk,
                          yValueMapper: (Dat e, _) => e.eas,
                          name: 'EAS',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true)),
                    ]),
                  SfCircularChart(
                    
                    title: ChartTitle(text: 'Chart Nilai ETS',textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  
                    legend: Legend(isVisible: true),
                    
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CircularSeries<Dat, String>>[
                      PieSeries<Dat, String>(
                          dataSource: datas,
                          xValueMapper: (Dat e, _) => e.nama_mk,
                          yValueMapper: (Dat e, _) => e.ets,
                          name: 'ETS',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
                    
                ],
              ),
            ),
          ),   
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dosen()));
          },
          child: const Icon(Icons.refresh, color: Colors.white),
          backgroundColor: Color.fromARGB(255, 184, 23, 23),
        )   
      );
  }
}

class Dat {
  final String nama_mk;
  final int eas;
  final int ets;

  Dat({this.nama_mk, this.eas, this.ets});

  factory Dat.fromMap(Map<String, dynamic> map){
    return Dat(nama_mk: map["nama_mk"], eas: int.parse(map["eas"]), ets: int.parse(map["ets"]));
  }
}


