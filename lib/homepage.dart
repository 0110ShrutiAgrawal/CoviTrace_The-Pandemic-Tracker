import 'dart:convert';

import 'package:covidtracker/datasource.dart';
import 'package:covidtracker/pages/countrypage.dart';
import 'package:covidtracker/panels/infoPanel.dart';
import 'package:covidtracker/panels/mosteffectedcountries.dart';
import 'package:covidtracker/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<dynamic, dynamic> worldData = {};
  fetchWorldWideData() async {
    var url = Uri.parse("https://corona.lmao.ninja/v3/covid-19/all");
    http.Response response = await http.get(url);
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData = [];
  fetchCountryData() async {
    var url = Uri.parse("https://corona.lmao.ninja/v3/covid-19/countries");
    http.Response response = await http.get(url);
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          centerTitle: false,
          title: Text(
            'COVITRACE- The Pandemic Tracker App',
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: Colors.amber[50],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Global View',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Zonal',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              worldData == null
                  ? CircularProgressIndicator()
                  : WorldwidePanel(
                      worldData: worldData,
                    ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most Impacted Nations',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(
                      countryData: countryData,
                    ),
              InfoPanel(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'WE ARE ALL WARRIORS AGAINST THE VIRUS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[900]),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50, // Adjust the height as needed
                color: Colors.pink, // Customize the color
                child: Center(
                  child: Text(
                    'Covitrace - Copyright © 2023',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ])));
  }
}
