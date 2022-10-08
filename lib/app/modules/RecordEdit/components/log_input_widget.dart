import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/base_model.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/record_edit_controller.dart';
import 'package:get/get.dart';

class LogInputWidget extends StatelessWidget {
  LogInputWidget(
      {Key? super.key,
      required this.log,
      required this.onSave,
      required this.onCancel});

  final Function onSave;
  final Function onCancel;
  final LogDetail log;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecordEditController>();
    final subLoction = <int>[].obs;
    final actions = <int>[].obs;
    final remove = false.obs;
    final remove_d = false.obs;

    final commentCtrl = TextEditingController();

    subLoction.value = DBService.base.getSubLocation(log.location);

    actions.value = DBService.base.frogAction.keys.toList();

    remove.value = DBService.base.frogs[log.frog]!.remove;
    remove_d.value = log.remove;
    commentCtrl.text = log.comment;

    return Obx(
      () {
        final myInputTextStyle = TextStyle(
          fontSize: 18,
          height: 1.0,
          color: Theme.of(context).colorScheme.onBackground,
        );
        return Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  if (remove.value)
                    Flexible(
                      flex: 2,
                      child: CheckboxListTile(
                        title: const Text(
                          "移除",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        value: remove_d.value,
                        onChanged: (bool? value) {
                          remove_d.value = !remove_d.value;
                          log.remove = remove_d.value;
                        },
                      ),
                    ),
                  Flexible(
                    flex: 5,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '蛙種',
                        // prefixIcon: Icon(Icons.catching_pokemon),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: myInputTextStyle,
                      // value: controller.detail!.wind,
                      value: log.frog,
                      isExpanded: true,
                      items: controller.plot!.frogs
                          .map<DropdownMenuItem<int>>(
                            (int frog) => DropdownMenuItem(
                              value: frog,
                              child: Text(DBService.base.frogs[frog]!.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        log.frog = value!;
                        remove.value = DBService.base.frogs[log.frog]!.remove;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '型態',
                        // prefixIcon: Icon(Icons.format_size),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: myInputTextStyle,
                      // value: controller.detail!.wind,
                      value: log.sex,
                      isExpanded: true,
                      items: DBService.base.sex.entries
                          .map<DropdownMenuItem<int>>(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(
                                e.value.nickName,
                                style: TextStyle(
                                  color: e.value.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => log.sex = value!,
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
                        labelText: '棲地類型',
                        // prefixIcon: Icon(Icons.water),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: myInputTextStyle,
                      // value: controller.detail!.wind,
                      value: log.location,
                      isExpanded: true,
                      items: DBService.base.location.entries
                          .map<DropdownMenuItem<int>>(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        log.location = value!;

                        subLoction.value =
                            DBService.base.getSubLocation(log.location);

                        log.subLocation =
                            DBService.base.location[value]!.defaultSubLocation;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '子棲地',
                        // prefixIcon: Icon(Icons.park),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: myInputTextStyle,
                      // value: controller.detail!.wind,
                      value: log.subLocation,
                      isExpanded: true,
                      items: subLoction.value
                          .map<DropdownMenuItem<int>>(
                            (int key) => DropdownMenuItem(
                              value: key,
                              child:
                                  Text(DBService.base.subLocation[key]!.name),
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
                        // prefixIcon: Icon(Icons.emoji_people),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: myInputTextStyle,
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
                          actions.value = [3];
                        } else {
                          actions.value =
                              DBService.base.frogAction.keys.toList();
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
                        labelText: '成體型為',
                        // prefixIcon: Icon(Icons.emoji_people),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: myInputTextStyle,
                      value: log.action,
                      isExpanded: true,
                      items: actions
                          .map<DropdownMenuItem<int>>(
                            (int key) => DropdownMenuItem(
                              value: key,
                              child: Text(DBService.base.frogAction[key]!.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => log.action = value!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '數量',
                        // prefixIcon: Icon(Icons.emoji_people),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: myInputTextStyle,
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
                              child: Text(item.toString()),
                            ),
                          )
                          .toList(),

                      onChanged: (value) => log.amount = value!,
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
                    child: TextFormField(
                      controller: commentCtrl,
                      decoration: const InputDecoration(
                        labelText: '備註',
                        prefixIcon: Icon(Icons.comment),
                      ),
                      style: myInputTextStyle,
                    ),
                  ),
                  if (controller.plot!.sub_location.isNotEmpty) ...[
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: '子樣區',
                          // prefixIcon:Icon(Icons.scatter_plot_outlined, size: 14),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                        iconSize: 0,
                        style: myInputTextStyle,
                        value: log.locTag,
                        isExpanded: true,
                        items: controller.plot!.sub_location
                            .asMap()
                            .entries
                            .map<DropdownMenuItem<int>>(
                              (e) => DropdownMenuItem(
                                value: e.key,
                                child: Text(e.value),
                              ),
                            )
                            .toList(),
                        onChanged: (int? value) => log.locTag = value!,
                      ),
                    ),
                  ],
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
                    controller.plot!.tags.length,
                    (index) => ActionChip(
                      elevation: 6.0,
                      // backgroundColor: Colors.white,
                      // shape: StadiumBorder(
                      //     side: BorderSide(
                      //   width: 1,
                      //   color: Colors.blueAccent,
                      // )),
                      label: Text(controller.plot!.tags[index]),
                      onPressed: () {
                        if (log.comment.trim() == '') {
                          log.comment = controller.plot!.tags[index];
                        } else {
                          final words = log.comment.split(',');
                          if (!words.contains(controller.plot!.tags[index])) {
                            words.add(controller.plot!.tags[index]);
                            log.comment = words.join(',');
                          }
                        }

                        commentCtrl.text = log.comment;
                      },
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
                        minimumSize: const Size.fromHeight(40), // NEW
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      child: const Text('取消'),
                      onPressed: () async {
                        onCancel();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40), // NEW
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: const Text('確定'),
                      onPressed: () {
                        log.comment = commentCtrl.text;
                        onSave();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
        );
      },
    );
  }
}
