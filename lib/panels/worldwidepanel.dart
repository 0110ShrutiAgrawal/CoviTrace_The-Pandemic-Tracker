import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;
  const WorldwidePanel({super.key, required this.worldData});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Color(0xFFFFF3E0),
            textColor: Color(0xFF795548),
            count: worldData['cases'].toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Color(0xFFBA68C8),
            textColor: Color(0xFFFFFFFF),
            count: worldData['active'].toString(),
          ),
          StatusPanel(
              title: 'RECOVERED',
              panelColor: Color(0xFF66BB6A),
              textColor: Color(0xFFF4FF81),
              count: worldData['recovered'].toString()),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Color(0xFFB2DFDB),
            textColor: Color(0xFF004D40),
            count: worldData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key? key,
      required this.panelColor,
      required this.textColor,
      required this.title,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
