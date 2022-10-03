import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/provider/plot_provider.dart';
import 'package:flutter_froghome_app/app/data/provider/base_provider.dart';

class DBService extends GetxService {
  static final _base_provider = BaseProvider();
  static final _plot_provider = PlotProvider();

  static BaseProvider get base => _base_provider;
  static PlotProvider get plot => _plot_provider;

  Future<DBService> init() async {
    print('_________DBService init___________');
    await Hive.initFlutter();
    Hive.registerAdapter(PlotAdapter());
    _base_provider.init();
    await _plot_provider.init();
    return this;
  }
}
