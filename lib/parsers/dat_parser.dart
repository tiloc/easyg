import 'dart:typed_data';

import 'package:easyg/model/ecg.dart';
import 'package:easyg/model/lead.dart';

/// Primitive parser to read 2 channel signed 16 bit ECGs.
/// Example: https://physionet.org/content/aftdb/1.0.0/test-set-a/
class DatParser {
  static Ecg parseDat(Uint8List rawDatBytes) {
    final int elementsPerLead = rawDatBytes.length >> 2;
    final Int16List leadIData = Int16List(elementsPerLead);
    final Int16List leadIIData = Int16List(elementsPerLead);

    for (int i = 0; i < elementsPerLead; i++) {
      leadIData[i] = rawDatBytes.buffer.asInt16List(i * 4, 1).first;
      leadIIData[i] = rawDatBytes.buffer.asInt16List(i * 4 + 2, 1).first;
    }

    // TODO: This currently hard-coded for one particular data set.
    final leadI = Lead(name: 'I', rawAD: leadIData, aduPermV: 170.94);
    final leadII = Lead(name: 'II', rawAD: leadIIData, aduPermV: 140.056);

    return Ecg(frequency: 128.0, leads: [leadI, leadII]);
  }
}
