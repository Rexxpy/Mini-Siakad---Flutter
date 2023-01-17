import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqs/edit.dart';
import 'package:sqs/login.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  
  String nbi,nama_mk,dosen_id,presensi,eas,ets,predikat;

  List<Nilai> nilaimhsw = <Nilai>[];
  DataNilaiSource datnilaiDataSource;

  TabController tabController;


  adddata() async {
    final response = await http.post(
        "http://192.168.6.100:81/flutter/tambah.php",
        body: {"nbi": '', "nama_mk": '', "dosen_id": '', "presensi": '', "eas": '', "ets": '', "predikat": ''});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];   
    print(pesan);
  }

  getdata() async{
    var url = "http://192.168.6.100:81/flutter/show.php";
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  getdataNilai() async {
    var url = "http://192.168.6.100:81/flutter/show.php";
 
    final response = await http.get(url);
    var list = json.decode(response.body);
    List<Nilai> _nilai =
        await list.map<Nilai>((json) => Nilai.fromJson(json)).toList();
    datnilaiDataSource = DataNilaiSource(_nilai);
    return _nilai;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Dashboard")),
                Tab(child: Text("Data Nilai")),
              ]
            ),
            backgroundColor: Color.fromARGB(255, 184, 23, 23),
            centerTitle: true,
            title: Text("Mahasiswa Page"),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                },
                icon: Icon(Icons.lock_open),
              )
            ],
          ),
          body: TabBarView(
            children: [
              Center(
                child: FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done);
                      return snapshot.hasData 
                      ? ListView.builder(
                        itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,
                        itemBuilder: (context, index) {
                          // index++;
                          List list = snapshot.data;
                          return Card(
                            color: Colors.white,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3,color: Color.fromARGB(255, 160, 23, 23)),
                              borderRadius: BorderRadius.circular(15),   
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditData(list:list,index:index,),),);
                              },
                              title: Text("Data nilai mahasiswa ke $index"),
                              trailing: GestureDetector(
                                child: Icon(Icons.delete),
                                onTap: () {
                                  setState(() {
                                    var url = "http://192.168.6.100:81/flutter/delete.php";
                                    http.post(url,body:{
                                      'id': list[index]['id'],
                                    });                              
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainMenu()),                          
                                  );
                                },
                              )
                            ),
                          );
                        })
                        :Center(
                          child: CircularProgressIndicator(),
                        );
                  },
                ),
              ),
              
                  FutureBuilder(
                    future: getdataNilai(),
                    builder: (context,data) {
                      return data.hasData ?
                      SfDataGrid(
                        source: datnilaiDataSource, 
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        columnWidthMode: ColumnWidthMode.fill,
                        columns: <GridColumn>[
                            GridColumn(
                                columnName: 'nb',
                                label: Container(
                                    padding: EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    color: Color.fromARGB(255, 168, 56, 41),
                                    child: Text(
                                      'NBI',
                                     style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.white),
                                    ))),
                            GridColumn(
                                columnName: 'mk',
                                label: Container(
                                    padding: EdgeInsets.all(13.0),
                                    alignment: Alignment.center,
                                    color: Color.fromARGB(255, 168, 56, 41),
                                    child: Text(
                                      'Matkul',
                                     style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.white),
                                    ))),
                            GridColumn(
                                columnName: 'et',
                                label: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                   color: Color.fromARGB(255, 168, 56, 41),
                                    child: Text(
                                      'ETS',
                                     style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.white),
                                    ))),
                            GridColumn(
                                columnName: 'ea',
                                label: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                   color: Color.fromARGB(255, 168, 56, 41),
                                    child: Text('EAS',
                                   style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.white),
                                    ))),
                            GridColumn(
                                columnName: 'predi',
                                label: Container(
                                    padding: EdgeInsets.all(8.0),
                                   color: Color.fromARGB(255, 168, 56, 41),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Predikat',
                                     style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                          ],
                             stackedHeaderRows: <StackedHeaderRow>[
                              StackedHeaderRow(cells: [
                                StackedHeaderCell(
                                    columnNames: ['nb','et', 'ea','mk','predi'],
                                    child: Container(
                                       color: Color.fromARGB(255, 100, 12, 0),
                                        child: Center(child: 
                                        Text('Daftar Nilai Mahasiswa',
                                         style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.white),
                                        )))),
                              ])
                            ]
                      )
                      : Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  ),
              
            ],
          ),
            floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 184, 23, 23),
            tooltip: 'Tambah Data',
              onPressed: () {
                  adddata();
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainMenu()),
                          
                  );
              },
            ),
      ),
    );
  }

}


class DataNilaiSource extends DataGridSource {
 
  DataNilaiSource(this.nilaimhsw) {
    buildDataGridRow();
  }
 
  void buildDataGridRow() {
    _employeeDataGridRows = nilaimhsw
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'nbi', value: e.nb),
              DataGridCell<String>(columnName: 'mk', value: e.mk),
              DataGridCell<int>(columnName: 'et', value: e.et),
              DataGridCell<int>(columnName: 'ea', value: e.ea),
              DataGridCell<String>(columnName: 'predi', value: e.predi),
            ]))
        .toList();
  }
 
  List<Nilai> nilaimhsw = [];
 
  List<DataGridRow> _employeeDataGridRows = [];
 
  @override
  List<DataGridRow> get rows => _employeeDataGridRows;
 
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
 
  void updateDataGrid() {
    notifyListeners();
  }
}
 
class Nilai {
  String nb;
  String mk;
  int et;
  int ea;
  String predi;
 
  Nilai({this.nb, this.mk, this.et, this.ea, this.predi});
 
  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(
        nb: json['nbi'],
        mk: json['nama_mk'],
        et: int.parse(json['ets']),
        ea: int.parse(json['eas']),
        predi: json['predikat']);
  }
}
