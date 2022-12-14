// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordList/record_list_controller.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

Future<void> editRecord(BuildContext context, int? index) async {
  final controller = Get.find<RecordListController>();
  if (index == null) {
    controller.Add();
  } else {
    controller.Edit(index);
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Obx(
      () {
        var textStyle = TextStyle(
          height: 1.0,
          color: Theme.of(context).colorScheme.onBackground,
        );
        return Container(
          padding: EdgeInsets.fromLTRB(
            5,
            15,
            5,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: '樣區',
                          prefixIcon: Icon(Icons.park_outlined),
                        ),
                        iconSize: 0,
                        style: textStyle,
                        value: controller.editLog.plot,
                        isExpanded: true,
                        items: DBService.plot.values
                            .map<DropdownMenuItem<int>>(
                              (Plot plot) => DropdownMenuItem(
                                value: plot.key,
                                child: Text(plot.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => controller.editLog.plot =
                            DBService.plot.values
                                .firstWhere((element) => element.key == value)
                                .key,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: '調查日期',
                        ),
                        readOnly: true,
                        style: textStyle,
                        controller: controller.dateCtrl,
                        onTap: () => showDatePicker(
                          context: context,
                          locale: const Locale('zh', 'TW'),
                          initialDate: controller.editLog.date,
                          firstDate: Jiffy()
                              .startOf(Units.YEAR)
                              .add(years: -2)
                              .dateTime,
                          lastDate:
                              Jiffy().endOf(Units.YEAR).add(years: 1).dateTime,
                        ).then(
                          (value) {
                            if (value != null) {
                              controller.editLog.date = value;
                              controller.dateCtrl.text =
                                  Jiffy(value).format('MM-dd');
                              ;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.watch_later_outlined),
                          labelText: '開始時間',
                        ),
                        style: textStyle,
                        controller: controller.stimeCtrl,
                        onTap: () => showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(controller.editLog.stime),
                        ).then(
                          (pickedTime) {
                            if (pickedTime != null) {
                              controller.editLog.stime = Jiffy({
                                "hour": pickedTime.hour,
                                "minute": pickedTime.minute
                              }).dateTime;
                              controller.stimeCtrl.text =
                                  Jiffy(controller.editLog.stime)
                                      .format('HH:mm');
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.watch_later_outlined),
                          labelText: '結束時間',
                        ),
                        style: textStyle,
                        controller: controller.etimeCtrl,
                        onTap: () => showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(controller.editLog.etime),
                        ).then(
                          (pickedTime) {
                            if (pickedTime != null) {
                              controller.editLog.etime = Jiffy({
                                "hour": pickedTime.hour,
                                "minute": pickedTime.minute
                              }).dateTime;
                              controller.etimeCtrl.text =
                                  Jiffy(controller.editLog.etime)
                                      .format('HH:mm');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: '天氣',
                          prefixIcon: Icon(Icons.sunny_snowing),
                        ),
                        iconSize: 0,
                        style: textStyle,
                        // value: controller.detail!.wind,
                        value: controller.editLog.weather,
                        isExpanded: true,
                        items: ['晴', '多雲', '陰', '小雨', '大雨']
                            .map<DropdownMenuItem<String>>(
                              (str) => DropdownMenuItem(
                                value: str,
                                child: Text(str),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            controller.editLog.weather = value,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.thermostat),
                          labelText: '溫度',
                        ),
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        controller: controller.t1Ctrl,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.water_drop),
                          labelText: '濕度',
                        ),
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        controller: controller.t2Ctrl,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.water),
                          labelText: '水溫',
                        ),
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        controller: controller.t3Ctrl,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.people),
                    labelText: '參與人員',
                  ),
                  style: textStyle,
                  controller: controller.memberCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.comment),
                    labelText: '其它備註',
                  ),
                  style: textStyle,
                  controller: controller.commentCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.create_new_folder),
                      Text('存檔'),
                    ],
                  ),
                  onPressed: () async {
                    await controller.save();
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    ),
  );
}
