import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email, password, nama;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response = await http.post(
        "http://192.168.6.100:81/flutter/register.php",
        body: {"nama": nama, "email": email, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
       
      });
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
        backgroundColor: Color.fromARGB(255, 184, 23, 23),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              
              Container(height: 50,),
          
              Container(
                  padding: EdgeInsets.only(right: 160,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Register', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800),),    
                    ],
                  ),
              ),
          
              Container(height: 50,),
          
              Container(
                  padding: EdgeInsets.only(right: 145),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Please input your data', 
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Color.fromARGB(111, 0, 0, 0)),),    
                    ],
                  ),
              ),
          
              Container(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "please input your name";
                        }
                      },
                      onSaved: (e) => nama = e,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                        labelText: 'Your Name',
                        suffixIcon: Icon(Icons.perm_identity),
                      ),
                    ),
                  ),
                ],
              ),
      
              Container(height: 20,),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "please input email";
                        }
                      },
                      onSaved: (e) => email = e,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                        labelText: 'Your Email',
                        suffixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextFormField(
                      obscureText: _secureText,
                      onSaved: (e) => password = e,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(
                              _secureText ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              Container(height: 20,),
          
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
                           check();
                        }, 
                        child: Text('Register',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
                      ),
                    ),        
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
