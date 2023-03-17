import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SensorValue {
  final DateTime time;
  final double value;

  SensorValue(this.time, this.value);
}

class Chart extends StatelessWidget {
  // const Chart({Key? key}) : super(key: key);
  final List<SensorValue> _data;

  Chart(this._data);

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart([
      charts.Series<SensorValue, DateTime>(
        id: 'Values',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SensorValue values, _) => values.time,
        measureFn: (SensorValue values, _) => values.value,
        data: _data,
      )
    ],
        animate: false,
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(zeroBound: false),
          renderSpec: charts.NoneRenderSpec(),
        ),
        domainAxis: new charts.DateTimeAxisSpec(
            renderSpec: new charts.NoneRenderSpec()));
  }
}
