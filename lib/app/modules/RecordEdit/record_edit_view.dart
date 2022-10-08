import 'package:flutter/material.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/components/frog_item_widget.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';

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
              itemBuilder: (context) => <PopupMenuEntry<int>>[
                const PopupMenuItem(
                  value: 0,
                  child: Text('Download'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('State'),
                ),
                const PopupMenuDivider(height: 1),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Clear'),
                ),
                const PopupMenuDivider(height: 1),
                CheckedPopupMenuItem(
                  child: Text('連續輸入'),
                  checked: controller.continueInput,
                  value: 3,
                ),
              ],
              onSelected: (value) {
                print(value);
                if (value == 1) {
                  Get.toNamed(Routes.RECORD_STATE(controller.logKey));
                } else if (value == 3) {
                  controller.continueInput = !controller.continueInput;
                }
              },
            ),
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
