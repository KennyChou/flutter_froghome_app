import 'package:flutter/material.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/components/frog_item_widget.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'components/log_input_widget.dart';
import 'record_edit_controller.dart';

class RecordEditView extends GetView<RecordEditController> {
  const RecordEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (frogLog) => Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => const <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Download'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('State'),
                ),
                PopupMenuDivider(height: 1),
                PopupMenuItem(
                  value: 2,
                  child: Text('Clear'),
                ),
              ],
              onSelected: (value) {
                print(value);
              },
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    DBService.plot.getName(frogLog!.plot),
                  ),
                ),
              ),
              Text(
                Jiffy(frogLog.date).format('yyyy-MM-dd'),
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showEditLog(context, null),
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: DBService.logs.values.length,
            itemBuilder: (context, index) => FrogItemWidget(
              log: DBService.logs.values[index],
              plot: controller.plot!,
              onDelete: () => DBService.logs.delete(index),
              onEdit: () => showEditLog(context, index),
              locColor: null,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showEditLog(BuildContext context, int? index) async {
  final controller = Get.find<RecordEditController>();
  if (index == null) {
    controller.Add();
  } else {
    controller.Edit(index);
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => SingleChildScrollView(
      child: Obx(
        () => LogInputWidget(
          log: controller.current!,
          onCancel: () => Navigator.pop(context),
          onSave: () {
            controller.Save();
            if (!controller.continueInput) {
              Navigator.pop(context);
            } else {
              controller.Add();
            }
          },
        ),
      ),
    ),
  );
}
