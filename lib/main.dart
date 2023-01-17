import 'package:flutter/material.dart';
import 'package:sqs/login.dart';

void main() {
  runApp(
    MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Login',
    home: Login(),
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
  ));
}
