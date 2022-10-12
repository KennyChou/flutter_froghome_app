import 'package:flutter/material.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/components/frog_item_widget.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'components/frog_edit_widget.dart';

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
                  child: Text('產生Excel'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('統計'),
                ),
                const PopupMenuDivider(height: 1),
                CheckedPopupMenuItem(
                  checked: controller.continueInput.value,
                  value: 2,
                  child: const Text('連續輸入'),
                ),
              ],
              onSelected: (value) async {
                if (value == 1) {
                  showState(context);
                } else if (value == 2) {
                  controller.continueInput.value =
                      !controller.continueInput.value;
                  controller.continueInput.refresh();
                } else {
                  controller.writeExcel();
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
          child: const Icon(Icons.add),
          onPressed: () async => await showEditLog(context, null),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: DBService.logs.values.length,
            itemBuilder: (context, index) => FrogItemWidget(
              log: DBService.logs.values[index],
              plot: controller.plot,
              onDelete: () {
                Get.defaultDialog(
                  title: '確定刪除?',
                  content: Text(DBService
                      .base.frogs[DBService.logs.values[index].frog]!.name),
                  textCancel: '取消',
                  textConfirm: '確定',
                  onConfirm: () {
                    DBService.logs.delete(index);
                    controller.updatedKey.value = -1;
                    Navigator.of(context).pop();
                  },
                );
              },
              onEdit: () => showEditLog(context, index),
              onChangeAmount: (value) {
                DBService.logs.values[index].amount =
                    DBService.logs.values[index].amount + value;
                if (DBService.logs.values[index].amount < 1) {
                  DBService.logs.values[index].amount = 1;
                }
                controller.editLog.value = DBService.logs.values[index];
                controller.Save();
              },
              editColor: (DBService.logs.values[index].key ==
                          controller.updatedKey.value ||
                      (index == 0 && controller.updatedKey.value == -2))
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
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
    builder: (context) => FrogEditWidget(
      controller: controller,
      onCancel: () => Navigator.pop(context),
      onSave: () {
        controller.Save();
        if (!controller.continueInput.value || index != null) {
          Navigator.pop(context);
        } else {
          controller.Add();
        }
      },
    ),
  );
}

Future<void> showState(BuildContext context) async {
  final controller = Get.find<RecordEditController>();
  controller.stateData();
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
            '共 ${controller.statFamily.length}科  ${controller.statFrog.keys.length}種'),
        Expanded(
          child: ListView.builder(
            itemCount: controller.statFamily.length,
            itemBuilder: (BuildContext context, int index) {
              final family = controller.statFamily[index];
              final frogs = DBService.base.frogs.entries
                  .where((e) =>
                      controller.statFrog.containsKey(e.key) &&
                      e.value.family == family)
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DBService.base.family[family]!.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  ...frogs
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.value.name,
                              ),
                              Row(
                                children: [
                                  if (e.value.remove) ...[
                                    Text(controller.statFrog[e.key]!['remove']
                                        .toString()),
                                    const Text(' / '),
                                  ],
                                  Text(controller.statFrog[e.key]!['qty']
                                      .toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList()
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40), // NEW
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('複製到剪貼簿'),
            onPressed: () => controller.copyClipboard(),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}
