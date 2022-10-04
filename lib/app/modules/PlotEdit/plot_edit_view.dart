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
    return Scaffold(
      appBar: AppBar(
        title: const Text('編輯樣區資料'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async => await controller.Save(),
      ),
      body: controller.obx(
        (plot) => Column(
          children: [
            ListTile(
              title: TextField(
                controller: controller.nameCtrl,
                focusNode: controller.nameFocus,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '樣區名稱',
                ),
              ),
            ),
            ListTile(
              title: MultiSelectDialogField(
                initialValue: plot!.frogs,
                buttonText: const Text('可能蛙種'),
                title: const Text('選取蛙種'),
                // itemsTextStyle: TextStyle(color: Colors.white),
                items: DBService.base.frogs
                    .map((frog) => MultiSelectItem(frog.id, frog.name))
                    .toList(),
                onConfirm: (List<int> values) {
                  plot.frogs = values;
                },
              ),
            ),
            ListTile(
              title: Tags(
                textField: TagsTextField(
                  // focusNode: controller.subFoccus,
                  hintText: '輸入子樣區',
                  onSubmitted: (val) => controller.addSub(val),
                ),
                itemCount: plot.sub_location.length,
                itemBuilder: (int index) {
                  return ItemTags(
                    title: plot.sub_location[index],
                    index: index,
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: () {
                        controller.removeSub(index);
                        controller.subFoccus.requestFocus();
                        return true;
                      },
                    ),
                    pressEnabled: false,
                  );
                },
              ),
            ),
            ListTile(
              title: Tags(
                textField: TagsTextField(
                  // focusNode: controller.tagFoucs,
                  hintText: '新增標籤',
                  onSubmitted: (val) {
                    controller.addTags(val);
                    controller.tagFoucs.requestFocus();
                  },
                ),
                itemCount: plot.tags.length,
                itemBuilder: (int index) {
                  return ItemTags(
                    title: plot.tags[index],
                    index: index,
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: () {
                        controller.removeTags(index);
                        controller.tagFoucs.requestFocus();
                        return true;
                      },
                    ),
                    pressEnabled: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
