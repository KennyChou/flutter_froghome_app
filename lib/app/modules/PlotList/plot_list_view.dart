import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

import 'plot_list_controller.dart';

class PlotListView extends GetView<PlotListController> {
  const PlotListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fsdfadfaf'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.add(),
        child: const Icon(Icons.place),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: DBService.plot.values.length,
            itemBuilder: (BuildContext context, index) {
              final plot = DBService.plot.values[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(plot.name),
                    onTap: () => Get.toNamed(Routes.PLOT_EDIT(plot.key)),
                    onLongPress: () async => await DBService.plot.delete(plot),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
