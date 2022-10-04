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
        title: const Text('PlotEditView'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => Column(
          children: [
            ListTile(
              title: TextField(
                controller: controller.nameCtrl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '樣區名稱',
                ),
              ),
            ),
            ListTile(
              title: MultiSelectDialogField(
                buttonText: const Text('可能蛙種'),
                title: const Text('選取蛙種'),
                // itemsTextStyle: TextStyle(color: Colors.white),
                items: DBService.base.frogs
                    .map((frog) => MultiSelectItem(frog.id, frog.name))
                    .toList(),
                onConfirm: (List<dynamic> values) {
                  print(values);
                },
              ),
            ),
            ListTile(
              title: Tags(
                textField: TagsTextField(
                  hintText: '輸入子樣區',
                  onSubmitted: (str) => controller.tags.add(str),
                ),
                itemCount: controller.tags.length,
                itemBuilder: (int index) {
                  return ItemTags(
                    title: controller.tags[index],
                    index: index,
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: () {
                        controller.tags.removeAt(index);
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
