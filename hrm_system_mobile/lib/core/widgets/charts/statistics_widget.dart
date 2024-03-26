import 'dart:math';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>>? seriesList;
  final double height;
  final bool animate;

  // ignore: use_key_in_widget_constructors
  const GroupedBarChart({this.seriesList, this.animate = false, this.height = 200});

  factory GroupedBarChart.withSampleData() {
    return GroupedBarChart(
      seriesList: _createSampleData(),
      animate: false,
    );
  }

  factory GroupedBarChart.withRandomData() {
    return GroupedBarChart(seriesList: _createRandomData());
  }

  /// Create random data.
  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = Random();

    final tableSalesData = [
      OrdinalSales('2018', random.nextInt(100)),
      OrdinalSales('2019', random.nextInt(100)),
      OrdinalSales('2020', random.nextInt(100)),
      OrdinalSales('2021', random.nextInt(100)),
    ];

    final mobileSalesData = [
      OrdinalSales('2018', random.nextInt(100)),
      OrdinalSales('2019', random.nextInt(100)),
      OrdinalSales('2020', random.nextInt(100)),
      OrdinalSales('2021', random.nextInt(100)),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(color: Colors.white),
      child: charts.BarChart(
        // seriesList,
        _createRandomData(),
        animate: animate,
        barGroupingType: charts.BarGroupingType.grouped,
      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final tableSalesData = [
      OrdinalSales('2018', 25),
      OrdinalSales('2019', 50),
      OrdinalSales('2020', 10),
      OrdinalSales('2021', 20),
    ];

    final mobileSalesData = [
      OrdinalSales('2018', 10),
      OrdinalSales('2019', 15),
      OrdinalSales('2020', 50),
      OrdinalSales('2021', 45),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
