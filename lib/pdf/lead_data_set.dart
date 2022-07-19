import 'package:easyg/model/lead.dart';
import 'package:pdf/widgets.dart' as pw;

class LeadDataSet extends pw.LineDataSet<pw.PointChartValue> {
  final Lead lead;

  static List<pw.PointChartValue> toPointChartValues(Lead lead) {
    final chartPoints = <pw.PointChartValue>[];
    final milliVolts = lead.milliVolts;
    for(int i = 0; i < milliVolts.length; i++) {
      chartPoints.add(pw.PointChartValue(i * 0.05, milliVolts[i]));
    }

    return chartPoints;
  }

  LeadDataSet({required Lead lead}) : this.lead = lead, super(data: toPointChartValues(lead), legend: lead.name, drawPoints: false, lineWidth: 1);
}