import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import 'plot_list_controller.dart';

class PlotListView extends GetView<PlotListController> {
  const PlotListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.plots.isNotEmpty
          ? Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => controller.add(),
                child: const Icon(Icons.place),
              ),
              body: ListView.builder(
                itemCount: controller.plots.length,
                itemBuilder: (BuildContext context, index) {
                  final plot = controller.plots[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  title: Text('確定刪除[${plot.name}]'),
                                  content: const Text('請小心使用\n將會刪除該樣區全部的記錄！！'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('取消'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await controller.delete(plot);
                                            Get.back();
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                          ),
                                          child: const Text('確定'),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: '刪除',
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(Icons.park, size: 30),
                            title: Text(
                              plot.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            onTap: () => Get.rootDelegate
                                .toNamed(Routes.PLOT_EDIT(plot.key)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => controller.add(),
                child: const Icon(Icons.place),
              ),
              body: Center(
                child: Text(
                  '請先新增樣區！',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
    );
  }
}
