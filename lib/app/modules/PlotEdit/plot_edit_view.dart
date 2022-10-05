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
        (plot) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '樣區名稱',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                child: TextField(
                  controller: controller.nameCtrl,
                  focusNode: controller.nameFocus,
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.secondary,
                    fontSize: MediaQuery.of(context).size.width > 360 ? 16 : 14,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '樣區蛙種',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize:
                              MediaQuery.of(context).size.width > 360 ? 18 : 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '新增記錄時,減少選取蛙種',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                child: MultiSelectDialogField(
                  initialValue: plot!.frogs,
                  buttonText: const Text('選取蛙種'),
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
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '子樣區設定',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize:
                              MediaQuery.of(context).size.width > 360 ? 18 : 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '子樣區會自動產生在備註欄位',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                child: Tags(
                  textField: TagsTextField(
                    // focusNode: controller.subFoccus,
                    hintText: '輸入子樣區名稱',
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
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '備註標籤',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize:
                              MediaQuery.of(context).size.width > 360 ? 18 : 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '可輔助記錄備註填寫',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                child: Tags(
                  textField: TagsTextField(
                    // focusNode: controller.tagFoucs,
                    hintText: '輸入註備標籤',
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
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
