import 'package:covidtracker/datasource.dart';
import 'package:flutter/material.dart';
import 'package:covidtracker/homepage.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Circular', primaryColor: primaryBlack),
  ));
}
