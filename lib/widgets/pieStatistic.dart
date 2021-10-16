import 'package:flutter/material.dart';
import 'package:foody/flutter_flow/flutter_flow_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PieStatistic extends StatelessWidget {
  const PieStatistic({Key key, this.color, this.percent, this.statValueDisplay})
      : super(key: key);
  final Color color;
  final double percent;
  final String statValueDisplay;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 9.0,
        percent: this.percent,
        animation: true,
        animationDuration: 1200,
        center:Text(
          this.statValueDisplay,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        progressColor: this.color,
      ),
    );
  }
}
