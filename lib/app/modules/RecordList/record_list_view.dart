import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'record_list_controller.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/modules/RecordList/components/froglog_edit_bottom_sheet.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';

class RecordListView extends GetView<RecordListController> {
  const RecordListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.note_add),
        onPressed: () async => await editRecord(context, null),
      ),
      body: controller.obx(
        (froglogs) => ListView.builder(
            itemCount: froglogs!.length,
            itemBuilder: (context, index) {
              final FrogLog log = froglogs[index];
              return Obx(
                () => Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => editRecord(context, index),
                        backgroundColor: Colors.green,
                        icon: Icons.edit,
                        label: '編輯',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('確定刪除記錄'),
                            content: const Text('刪除就救不回來了喲！！'),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('取消'),
                                  ),
                                  const Spacer(flex: 1),
                                  TextButton(
                                    onPressed: () async {
                                      await controller.delete(index);
                                      Get.back();
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                    ),
                                    child: const Text('確定'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: '刪除',
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(
                              Icons.edit_calendar,
                              size: 40,
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              size: 40,
                            ),
                            title: Text(
                              DBService.plot.getName(log.plot),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            subtitle: Text(
                              "${Jiffy(log.date).format('yyyy-MM-dd')} ${Jiffy(log.stime).format('HH:mm')}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () => Get.rootDelegate
                                .toNamed(Routes.RECORD_EDIT(log.key)),
                          ),
                        ),
                      )),
                ),
              );
            }),
        onEmpty: Center(
          child: Text(
            '開始調查GO!',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
