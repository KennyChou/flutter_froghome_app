import 'package:flutter/foundation.dart';
import 'package:flutter_froghome_app/app/data/provider/frog_log_provider.dart';
import 'package:get/get.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/provider/plot_provider.dart';
import 'package:flutter_froghome_app/app/data/provider/base_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DBService extends GetxService {
  static final _base_provider = BaseProvider();
  static final _plot_provider = PlotProvider();
  static final _frogLog_provider = FrogLogProvider();

  static BaseProvider get base => _base_provider;
  static PlotProvider get plot => _plot_provider;
  static FrogLogProvider get frogLog => _frogLog_provider;

  Future<DBService> init() async {
    print('_________DBService init___________');

    if (kIsWeb) {
      Hive.initFlutter();
    } else {
      final appDocumentDir = await getApplicationSupportDirectory();
      // Hive.init(appDocumentDir.path);
      // await Hive.init(null);
      print(appDocumentDir.path);
      Hive.init(appDocumentDir.path);
    }
    Hive.registerAdapter(PlotAdapter());
    Hive.registerAdapter(FrogLogAdapter());
    Hive.registerAdapter(LogDetailAdapter());
    base.init();
    await frogLog.init();
    await plot.init();
    return this;
  }
}
