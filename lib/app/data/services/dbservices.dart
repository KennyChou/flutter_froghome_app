import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_froghome_app/app/data/provider/base_provider.dart';
import 'package:flutter_froghome_app/app/data/provider/frog_log_provider.dart';
import 'package:flutter_froghome_app/app/data/provider/log_privider.dart';
import 'package:flutter_froghome_app/app/data/provider/settings_model.dart';
import 'package:get/get.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/provider/plot_provider.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DBService extends GetxService {
  static final _base_provider = BaseV2Provider();
  static final _plot_provider = PlotProvider();
  static final _frogLog_provider = FrogLogProvider();
  static final _log_provider = LogProvider();
  static final _settings = SettingsProvider();

  static BaseV2Provider get base => _base_provider;
  static PlotProvider get plot => _plot_provider;
  static FrogLogProvider get frogLog => _frogLog_provider;
  static LogProvider get logs => _log_provider;
  static SettingsProvider get settings => _settings;

  static late final syspath;

  Future<DBService> init() async {
    print('_________DBService init___________');

    if (kIsWeb) {
      Hive.initFlutter();
      syspath = '';
    } else {
      syspath = (await getApplicationSupportDirectory()).path;
      // Hive.init(appDocumentDir.path);
      // await Hive.init(null);
      print(syspath);
      Hive.init(syspath);
    }
    Hive.registerAdapter(PlotAdapter());
    Hive.registerAdapter(FrogLogAdapter());
    Hive.registerAdapter(LogDetailAdapter());
    await settings.init();
    await frogLog.init();
    await plot.init();

    return this;
  }
}
