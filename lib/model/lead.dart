import 'dart:math';
import 'dart:typed_data';

class Lead {
  final String name;
  final Int16List rawAD;

  /// The amount of A/D units per milli-volt
  final double aduPermV;

  const Lead({required this.name, required this.rawAD, required this.aduPermV});

  List<double> get milliVolts => rawAD.map((adElement) => adElement / aduPermV).toList(growable: false);

  double get minMv => milliVolts.reduce(min);
  double get maxMv => milliVolts.reduce(max);
}
