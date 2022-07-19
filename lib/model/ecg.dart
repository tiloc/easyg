import 'package:easyg/model/lead.dart';

/// Representation of a multi-channel ECG
class Ecg {
  /// The frequency in Hertz
  final double frequency;

  final List<Lead> leads;

  const Ecg({required this.frequency, required this.leads});

  double get durationInSeconds => leads[0].rawAD.length / frequency;
}
