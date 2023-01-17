import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqs/main_menu.dart';

String pre = '';
int has = 0;
class EditData extends StatefulWidget {

  final int index;
  final List list;
  EditData({this.list,this.index});
  
  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  
  TextEditingController controllerNbi = TextEditingController();
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerDosen = TextEditingController(); 
  TextEditingController controllerPresensi = TextEditingController();
  TextEditingController controllerEts = TextEditingController();
  TextEditingController controllerEas = TextEditingController();

  void editData() {
    var url = "http://192.168.6.100:81/flutter/editdata.php";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "nbi": controllerNbi.text,
      "nama_mk": controllerNama.text,
      "dosen_id": controllerDosen.text,
      "presensi": controllerPresensi.text,
      "eas": controllerEas.text,
      "ets": controllerEts.text,
      "predikat": pre,
    });
  }

  void editPredikat(){
    if (has>=86) {
      setState(() {
        pre = 'A';
      });
    }else if (has>=81) {
      setState(() {
        pre = 'A-';
      });
    }else if (has>=76) {
      setState(() {
        pre = 'B+';
      });
    }else if (has>=71) {
      setState(() {
        pre = 'B';
      });
    }else if (has>=66) {
      setState(() {
        pre = 'B-';
      });
    }else if (has>=61) {
      setState(() {
        pre = 'C+';
      });
    }else if (has>=56) {
      setState(() {
        pre = 'C';
      });
    }else if (has>=51) {
      setState(() {
        pre = 'C-';
      });
    }else if (has>=46) {
      setState(() {
        pre = 'D+';
      });
    }else if (has>=0) {
      setState(() {
        pre = 'D';
      });
    }
  }


  @override
  void initState() {
    if(widget.index != null){
      controllerNbi.text = widget.list[widget.index]['nbi'];
      controllerNama.text = widget.list[widget.index]['nama_mk'];
      controllerDosen.text = widget.list[widget.index]['dosen_id'];
      controllerPresensi.text = widget.list[widget.index]['presensi'];
      controllerEas.text = widget.list[widget.index]['eas'];
      controllerEts.text = widget.list[widget.index]['ets'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Edit Page",
        ),
        backgroundColor: Color.fromARGB(255, 184, 23, 23),
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            Container(height: 50,),
          
            Container(
              padding: EdgeInsets.only(right: 153,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Edit Data', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800),),    
                ],
              ),
            ),        
            Container(height: 50,),
            
            Container(
              width: 300,
              child: new TextField(
                controller: controllerNbi,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                  labelText: 'NBI', hintText: 'NBI',
                ),
              ),
            ),
            Container(height: 20,),
            Container(
              width: 300,
              child: new TextField(
                controller: controllerNama,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                  labelText: 'Mata Kuliah', hintText: 'Mata Kuliah',
                ),
              ),
            ), 
            Container(height: 20,),
            Container(
              width: 300,
              child: new TextField(
                controller: controllerDosen,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                  labelText: 'ID Dosen', hintText: 'ID Dosen',
                ),
              ),
            ),
            Container(height: 20,),
            Container(
              width: 300,
              child: new TextField(
                controller: controllerPresensi,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                  labelText: 'Presensi', hintText: 'Presensi',
                ),
              ),
            ),
            Container(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  child: new TextField(
                    controller: controllerEas,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                      labelText: 'Nilai Eas', hintText: 'Nilai Eas',
                    ),
                  ),
                ),
                Container(width: 20,),
                Container(
                  width: 140,
                  child: new TextField(
                    controller: controllerEts,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                      labelText: 'Nilai Ets', hintText: 'Nilai Ets',
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 25,),
            
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [       
                    Container(
                      width: 300,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: Color.fromARGB(255, 173, 38, 38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: (){
                           setState(() {
                            double hus = 10/100*int.parse(controllerPresensi.text)+0.4*int.parse(controllerEts.text)+0.5*int.parse(controllerEas.text);
                            has = hus.round();
                            print(has);
                           });
                           editPredikat();
                           editData();
                           Navigator.of(context).pushReplacement(new MaterialPageRoute(
                            builder: (BuildContext context) => new MainMenu()));
                           }, 
                        child: Text('Edit Data',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
                      ),
                    ),        
                  ],
              ),
          ],
        ),
      ),
    );
  }
}