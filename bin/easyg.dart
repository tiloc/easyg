import 'dart:io';

import 'package:easyg/parsers/dat_parser.dart';
import 'package:easyg/pdf/lead_data_set.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> main(List<String> arguments) async {
  final ecg = DatParser.parseDat(File('./testdata/a01.dat').readAsBytesSync());

  print('$ecg');

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        children: ecg.leads
            .map((lead) => pw.Container(
                  height: 200,
                  child: pw.Chart(
                    grid: pw.CartesianGrid(
                      xAxis: pw.FixedAxis<double>(
                          List<double>.generate(
                              ecg.durationInSeconds.ceil() + 1,
                              (index) => index.toDouble(),
                              growable: false),
                          ticks: true,
                          divisions: true,
                          buildLabel: (time) => (time % 10 == 0)
                              ? pw.Text(DateFormat(DateFormat.MINUTE_SECOND)
                                  .format(
                                      DateTime(1970, 1, 1, 1, 0, time.toInt())))
                              : pw.Text('')),
                      yAxis: pw.FixedAxis<double>([lead.minMv, lead.maxMv],
                          format: (v) => v.toStringAsPrecision(2)),
                    ),
                    datasets: [LeadDataSet(lead: lead)],
                    left: pw.Text(lead.name),
                  ),
                ))
            .toList(growable: false),
      ),
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}
