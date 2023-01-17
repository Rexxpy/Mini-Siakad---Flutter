import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqs/register.dart';
import 'package:sqs/main_menu.dart';
import 'package:sqs/dosen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
   String email, password, status;
   String pesan = "Tidak ada data user";

  final _key = new GlobalKey<FormState>();

  TextEditingController emailName = TextEditingController();
  TextEditingController passName = TextEditingController();


  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  login() async {
    final response = await http.post("http://192.168.6.100:81/flutter/login.php",
        body: {"email": emailName.text, "password": passName.text});
    final data = jsonDecode(response.body);
    if (data.length < 1) {
      print(pesan);
    } else {
        setState(() {
            email = data[0]["email"];
            password = data[0]["password"];
            status= data[0]["status"];
        });
        if (status == 'dosen') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dosen()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainMenu()));
        }
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(  
          body: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  Container(
                  // width: 500,
                  padding: EdgeInsets.only(top: 90,bottom: 90,),
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(120),
                          bottomLeft: Radius.circular(0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 214, 103, 103),
                            Color.fromARGB(255, 184, 51, 51),
                          ]
                      ),
                  ),
                ),
          
                Container(height: 50,),
          
                Container(
                  padding: EdgeInsets.only(right: 200,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800),),    
                    ],
                  ),
                ),
          
                Container(height: 40,),
          
                Container(
                  padding: EdgeInsets.only(right: 125),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Please login to continue', 
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
                          controller: emailName,
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Harap masukkan email";
                              }
                            },
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
                         controller: passName,
                          validator: (e) {
                            return "Inputkan password";
                          },
                          obscureText: _secureText,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(width:3,color: Color.fromARGB(255, 184, 23, 23)),),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
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
                          login();
                        }, 
                        child: Text('Login',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
                      ),
                    ),       
                  ],
                ),

                Container(height: 20,),
                    
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // width: 300,
                        height: 45,
                        child: Text(
                              "Don't have an account ? ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                          ),
                      ),
                      Container(
                        // width: 300,
                        height: 45,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Register()));
                          },
                          child: Text(
                              " Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Color.fromARGB(255, 184, 23, 23)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
  }
}
