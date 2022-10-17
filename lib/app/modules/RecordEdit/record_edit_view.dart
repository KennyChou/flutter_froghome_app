import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/components/frog_item_widget.dart';
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
                if (!kIsWeb)
                  const PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      leading: Icon(Icons.share),
                      title: Text('分享Excel'),
                    ),
                  ),
                const PopupMenuItem(
                  value: 2,
                  child: ListTile(
                    leading: Icon(Icons.save),
                    title: Text('下載Excel'),
                  ),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: ListTile(
                    leading: Icon(Icons.poll_outlined),
                    title: Text('統計'),
                  ),
                ),
                const PopupMenuDivider(height: 2),
                CheckedPopupMenuItem(
                  checked: controller.continueInput.value,
                  value: 4,
                  child: const Text('連續輸入'),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case 3:
                    showState(context);
                    break;
                  case 4:
                    controller.continueInput.value =
                        !controller.continueInput.value;
                    controller.continueInput.refresh();
                    break;
                  default:
                    controller.writeExcel(value);
                    break;
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
          () => DBService.logs.values.isNotEmpty
              ? ListView.builder(
                  itemCount: DBService.logs.values.length,
                  itemBuilder: (context, index) => FrogItemWidget(
                    log: DBService.logs.values[index],
                    plot: controller.plot,
                    onDelete: () {
                      DBService.logs.delete(index);
                      controller.updatedKey.value = -1;
                    },
                    onEdit: () => showEditLog(context, index),
                    onChangeAmount: (value) {
                      DBService.logs.values[index].amount =
                          DBService.logs.values[index].amount + value;
                      if (DBService.logs.values[index].amount < 1) {
                        DBService.logs.values[index].amount = 1;
                      }
                      controller.editLog.value = DBService.logs.values[index];
                      controller.save(0);
                    },
                    editColor: (DBService.logs.values[index].key ==
                                controller.updatedKey.value ||
                            (index == 0 && controller.updatedKey.value == -2))
                        ? Theme.of(context).colorScheme.primaryContainer
                        : null,
                  ),
                )
              : Center(
                  child: Text(
                    '開始記錄蛙種',
                    style: Theme.of(context).textTheme.displaySmall,
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
    controller.add();
  } else {
    controller.edit(index);
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => FrogEditWidget(
      controller: controller,
      onCancel: () => Navigator.pop(context),
      onSave: () {
        controller.save(1);
        if (!controller.continueInput.value || index != null) {
          Navigator.pop(context);
        } else {
          controller.add();
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
    isScrollControlled: true,
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '共 ${controller.statFamily.length}科 ${controller.statFrog.keys.length}種',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ...controller.statFamily
            .map<Widget>(
              (int f) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DBService.base.family[f]!.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                          // direction: Axis.vertical,
                          // crossAxisAlignment: WrapCrossAlignment.end,
                          // crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: DBService.base.frogs.entries
                              .where((e) =>
                                  controller.statFrog.containsKey(e.key) &&
                                  e.value.family == f)
                              .map<Widget>(
                                (e) => Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  spacing: 0,
                                  children: [
                                    Text(
                                      e.value.name,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    if (e.value.remove) ...[
                                      Text(controller.statFrog[e.key]!['remove']
                                          .toString()),
                                      const Text('/'),
                                    ],
                                    Text(controller.statFrog[e.key]!['qty']
                                        .toString()),
                                  ],
                                ),
                              )
                              .toList()),
                    )
                  ],
                ),
              ),
            )
            .toList(),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: controller.statFamily.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       final family = controller.statFamily[index];
        //       final frogs = DBService.base.frogs.entries
        //           .where((e) =>
        //               controller.statFrog.containsKey(e.key) &&
        //               e.value.family == family)
        //           .toList();
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: Text(
        //               DBService.base.family[family]!.name,
        //               style: const TextStyle(fontSize: 20),
        //             ),
        //           ),
        //           ...frogs
        //               .map(
        //                 (e) => Padding(
        //                   padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(
        //                         e.value.name,
        //                       ),
        //                       Row(
        //                         children: [
        //                           if (e.value.remove) ...[
        //                             Text(controller.statFrog[e.key]!['remove']
        //                                 .toString()),
        //                             const Text(' / '),
        //                           ],
        //                           Text(controller.statFrog[e.key]!['qty']
        //                               .toString()),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               )
        //               .toList()
        //         ],
        //       );
        //     },
        //   ),
        // ),
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45), // NEW
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Text('複製到剪貼簿'),
              onPressed: () => controller.copyClipboard(),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}
