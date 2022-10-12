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
                        onPressed: (context) async =>
                            await controller.Delete(index),
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: '刪除',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: GestureDetector(
                      onTap: () {
                        Get.rootDelegate.toNamed(Routes.RECORD_EDIT(log.key));
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 50,
                                child: Icon(Icons.list),
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Text(DBService.plot.getName(log.plot),
                                      style: context.textTheme.bodyLarge),
                                  Text(
                                    "${Jiffy(log.date).format('yyyy-MM-dd')} ${Jiffy(log.stime).format('HH:mm')}",
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
        onEmpty: const Center(
          child: Text(
            '開始調查GO!',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
