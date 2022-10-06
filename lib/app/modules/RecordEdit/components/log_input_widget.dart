import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/base_model.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/record_edit_controller.dart';
import 'package:get/get.dart';

class LogInputWidget extends StatelessWidget {
  LogInputWidget({super.key});

  final controller = Get.find<RecordEditController>();
  final _log = Rxn<LogDetail>();
  get log => _log.value;
  set log(value) => _log.value = value;
  final subLoction = <SubLocation>[].obs;
  final actions = <FrogAction>[].obs;

  @override
  Widget build(BuildContext context) {
    log = controller.current;
    print(log);
    subLoction.value = DBService.base.location
        .firstWhere((element) => element.id == log.location)
        .children;
    actions.value = DBService.base.action;

    return Obx(
      () => Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Checkbox(
                      value: true,
                      onChanged: (bool? newValue) {
                        print(newValue);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '蛙種',
                        prefixIcon: Icon(Icons.catching_pokemon),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: controller.detail!.wind,
                      value: log.frog,
                      isExpanded: true,
                      items: controller.frogs
                          .map<DropdownMenuItem<int>>(
                            (Frog frog) => DropdownMenuItem(
                              value: frog.id,
                              child: Text(frog.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => log.frog = value!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '子樣區',
                        prefixIcon: Icon(Icons.scatter_plot_outlined),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: null,
                      isExpanded: true,
                      items: controller.plot.sub_location
                          .map<DropdownMenuItem<String>>(
                            (String sub) => DropdownMenuItem(
                              value: sub,
                              child: Text(sub),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => log.locTag = value!,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '型態',
                        prefixIcon: Icon(Icons.format_size),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: controller.detail!.wind,
                      value: log.sex,
                      isExpanded: true,
                      items: DBService.base.sex.value
                          .map<DropdownMenuItem<int>>(
                            (Sex sex) => DropdownMenuItem(
                              value: sex.id,
                              child: Text(sex.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => log.sex = value!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 3,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '棲地類型',
                        prefixIcon: Icon(Icons.water),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: controller.detail!.wind,
                      value: log.location,
                      isExpanded: true,
                      items: DBService.base.location.value
                          .map<DropdownMenuItem<int>>(
                            (Location location) => DropdownMenuItem(
                              value: location.id,
                              child: Text(location.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        log.location = value!;
                        final location = DBService.base.location.firstWhere(
                            (element) => element.id == log.location);
                        subLoction.value = location.children;

                        log.subLocation = location.defaultValue;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 3,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '子棲地',
                        prefixIcon: Icon(Icons.park),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: controller.detail!.wind,
                      value: log.subLocation,
                      isExpanded: true,
                      items: subLoction.value
                          .map<DropdownMenuItem<int>>(
                            (SubLocation item) => DropdownMenuItem(
                              value: item.id,
                              child: Text(item.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => log.subLocation = value!,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '觀察',
                        prefixIcon: Icon(Icons.emoji_people),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: controller.detail!.wind,
                      value: log.obs,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text('目擊'),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text('聽音'),
                        ),
                      ],
                      onChanged: (value) {
                        log.obs = value!;
                        if (log.obs == 1) {
                          log.action = 3;
                          actions.value = [FrogAction(id: 3, name: '嗚叫')];
                        } else {
                          actions.value = DBService.base.action;
                        }
                        print('${log.obs}    ${log.action}');
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '數量',
                        prefixIcon: Icon(Icons.emoji_people),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: controller.detail!.wind,
                      value: log.amount,
                      isExpanded: true,
                      items: [
                        0,
                        1,
                        2,
                        3,
                        4,
                        5,
                        6,
                        7,
                        8,
                        9,
                        10,
                        11,
                        12,
                        13,
                        14,
                        15,
                        16,
                        17,
                        18,
                        19,
                        20,
                        30,
                        40,
                        50
                      ]
                          .map<DropdownMenuItem<int>>(
                            (int item) => DropdownMenuItem(
                              value: item,
                              child: Text("${item}"),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => log.amount = value!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '成體型為',
                        prefixIcon: Icon(Icons.emoji_people),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      value: log.action,
                      isExpanded: true,
                      items: actions
                          .map<DropdownMenuItem<int>>(
                            (FrogAction item) => DropdownMenuItem(
                              value: item.id,
                              child: Text(item.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => log.action = value!,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: '備註',
                        prefixIcon: Icon(Icons.comment),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: List<Widget>.generate(
                    controller.plot.tags.length,
                    (index) => ActionChip(
                      elevation: 6.0,
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.blueAccent,
                      )),
                      label: Text(controller.plot.tags[index]),
                      onPressed: () => print('$index'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: Text('Save'),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: Text('Save'),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
