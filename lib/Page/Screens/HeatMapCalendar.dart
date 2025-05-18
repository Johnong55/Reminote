import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatefulWidget {
  const MyHeatMap({super.key});

  @override
  State<MyHeatMap> createState() => _MyHeatMapState();
}

class _MyHeatMapState extends State<MyHeatMap> {
  @override
  Widget build(BuildContext context) {
    return HeatMap(
  datasets: {
    DateTime(2021, 1, 6): 3,
    DateTime(2021, 1, 7): 7,
    DateTime(2021, 1, 8): 10,
    DateTime(2021, 1, 9): 13,
    DateTime(2021, 1, 13): 6,
  },
  colorMode: ColorMode.opacity,
  showText: false,
  scrollable: true,
  colorsets: {
    1: Colors.red,
    3: Colors.orange,
    5: Colors.yellow,
    7: Colors.green,
    9: Colors.blue,
    11: Colors.indigo,
    13: Colors.purple,
  },
  onClick: (value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
  },
);
  }
}