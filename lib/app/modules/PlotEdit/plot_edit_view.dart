import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: '設定',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '蛙種',
            ),
          ],
          currentIndex: controller.tabIndex.value,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (value) {
            controller.tabIndex.value = value;
            controller.update();
          },
        ),
        body: Obx(
          () => [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PlotHelp(title: '樣區名稱'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                    child: TextFormField(
                      controller: controller.nameCtrl,
                      focusNode: controller.nameFocus,
                      style: TextStyle(
                        // color: Theme.of(context).colorScheme.secondary,
                        fontSize:
                            MediaQuery.of(context).size.width > 360 ? 16 : 14,
                        fontWeight: FontWeight.normal,
                      ),
                      onFieldSubmitted: (val) => controller.autoSave(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: () => controller.autoSave(),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  const PlotHelp(title: '計數自動累加', help: '計數時會自動累加相同的資料'),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                        value: controller.plot.value.autoCount,
                        focusNode: controller.autoFocus,
                        onChanged: (bool value) {
                          controller.plot.value.autoCount = value;
                          controller.update();
                        }),
                  ),
                  const Divider(),
                  const PlotHelp(title: '子樣區設定', help: '子樣區會自動產生在備註欄位'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.subCtrl,
                          focusNode: controller.subFocus,
                          onFieldSubmitted: (val) {
                            controller.subAdd();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '新增子樣區',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.save),
                              onPressed: () => controller.subAdd(),
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 5,
                          children: controller.plot.value.sub_location
                              .map(
                                (f) => Chip(
                                  label: Text(
                                    f,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  deleteIcon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onDeleted: () async {
                                    controller.plot.value.sub_location
                                        .remove(f);
                                    controller.plot.refresh();
                                    await controller.autoSave();
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const PlotHelp(title: '備註標籤', help: '可輔助記錄備註填寫'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.memoCtrl,
                          focusNode: controller.tagFoucs,
                          onFieldSubmitted: (val) {
                            controller.tagAdd();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '新增備註標籤',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.save),
                              onPressed: () => controller.tagAdd(),
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 5,
                          children: controller.plot.value.tags
                              .map(
                                (f) => Chip(
                                  label: Text(
                                    f,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  deleteIcon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onDeleted: () async {
                                    controller.plot.value.tags.remove(f);
                                    controller.plot.refresh();
                                    await controller.autoSave();
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: ListBody(
                children: [
                  const PlotHelp(title: '樣區蛙種', help: '新增記錄時,減少選取蛙種'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                    child: Column(
                      // direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: DBService.base.family.entries
                          .map(
                            (f) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    f.value.name,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Wrap(
                                    spacing: 5,
                                    children: DBService.base.frogs.entries
                                        .where((element) =>
                                            element.value.family == f.key)
                                        .map(
                                          (f) => ChoiceChip(
                                            label: Text(
                                              f.value.name,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            selectedColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            selected: controller
                                                .plot.value.frogs
                                                .contains(f.key),
                                            onSelected: (selected) {
                                              if (selected) {
                                                controller.plot.value.frogs
                                                    .add(f.key);
                                              } else {
                                                controller.plot.value.frogs
                                                    .remove(f.key);
                                              }
                                              controller.plot.value.frogs.sort(
                                                  (a, b) => a.compareTo(b));
                                              controller.update();
                                              controller.autoSave();
                                            },
                                          ),
                                        )
                                        .toList()),
                                const Divider(),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ].elementAt(controller.tabIndex.value),
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
