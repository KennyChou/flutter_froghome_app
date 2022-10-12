import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'plot_edit_controller.dart';

class PlotEditView extends GetView<PlotEditController> {
  const PlotEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        appBar: AppBar(
          title: const Text('編輯樣區資料'),
          centerTitle: true,
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.save),
        //   onPressed: () async => await controller.autoSave(),
        // ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PlotHelp(title: '樣區名稱'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                  child: TextField(
                    controller: controller.nameCtrl,
                    focusNode: controller.nameFocus,
                    style: TextStyle(
                      // color: Theme.of(context).colorScheme.secondary,
                      fontSize:
                          MediaQuery.of(context).size.width > 360 ? 16 : 14,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: ElevatedButton(
                        child: const Icon(Icons.save),
                        onPressed: () => controller.autoSave(),
                      ),
                    ),
                    // onEditingComplete: () => controller.autoSave(),
                    // onChanged: (_) => controller.autoSave(),
                  ),
                ),
                const Divider(),
                const PlotHelp(title: '樣區蛙種', help: '新增記錄時,減少選取蛙種'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                  child: MultiSelectDialogField(
                    initialValue: controller.plot.value.frogs,
                    buttonText: const Text('選取蛙種'),
                    title: const Text('選取蛙種'),
                    items: DBService.base.frogs.entries
                        .map((e) => MultiSelectItem(e.key, e.value.name))
                        .toList(),
                    onConfirm: (List<int> values) {
                      if (values.length == 0) {
                        controller.plot.value.frogs =
                            DBService.base.frogs.keys.toList();
                      } else {
                        controller.plot.value.frogs = DBService.base.frogs.keys
                            .where((e) => values.contains(e))
                            .toList();
                      }
                      controller.plot.refresh();
                      controller.autoSave();
                    },
                  ),
                ),
                const Divider(),
                const PlotHelp(title: '計數自動累加', help: '計數時會自動累加相同的資料'),
                Align(
                  alignment: Alignment.centerRight,
                  child: Switch(
                      value: controller.plot.value.autoCount,
                      onChanged: (bool value) {
                        controller.plot.value.autoCount = value;
                        controller.update();
                      }),
                ),
                const Divider(),
                const PlotHelp(title: '子樣區設定', help: '子樣區會自動產生在備註欄位'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                  child: Tags(
                    textField: TagsTextField(
                        focusNode: controller.subFoccus,
                        hintText: '輸入子樣區名稱',
                        onSubmitted: (val) {
                          controller.plot.value.sub_location.add(val);
                          controller.plot.refresh();
                          controller.autoSave();
                          controller.subFoccus.requestFocus();
                        }),
                    itemCount: controller.plot.value.sub_location.length,
                    itemBuilder: (int index) {
                      return ItemTags(
                        title: controller.plot.value.sub_location[index],
                        index: index,
                        activeColor: Theme.of(context).colorScheme.tertiary,
                        removeButton: ItemTagsRemoveButton(
                          onRemoved: () {
                            controller.plot.value.sub_location.removeAt(index);
                            controller.autoSave();
                            controller.plot.refresh();
                            // controller.removeSub(index);
                            // controller.subFoccus.requestFocus();
                            // FocusScope.of(context)
                            //     .requestFocus(controller.subFoccus);
                            return true;
                          },
                        ),
                        pressEnabled: false,
                      );
                    },
                  ),
                ),
                const Divider(),
                const PlotHelp(title: '備註標籤', help: '可輔助記錄備註填寫'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                  child: Tags(
                    textField: TagsTextField(
                      focusNode: controller.tagFoucs,
                      hintText: '輸入註備標籤',
                      onSubmitted: (val) {
                        controller.plot.value.tags.add(val);
                        controller.autoSave();
                        controller.plot.refresh();
                        controller.tagFoucs.requestFocus();
                      },
                    ),
                    itemCount: controller.plot.value.tags.length,
                    itemBuilder: (int index) {
                      return ItemTags(
                        title: controller.plot.value.tags[index],
                        index: index,
                        activeColor: Theme.of(context).colorScheme.tertiary,
                        removeButton: ItemTagsRemoveButton(
                          onRemoved: () {
                            controller.plot.value.tags.removeAt(index);
                            controller.autoSave();
                            controller.plot.refresh();
                            controller.tagFoucs.requestFocus();

                            return true;
                          },
                        ),
                        pressEnabled: false,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlotHelp extends StatelessWidget {
  const PlotHelp({Key? key, required this.title, this.help = ''})
      : super(key: key);
  final String title;
  final String help;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Flexible(
            child: Text(
              help,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
