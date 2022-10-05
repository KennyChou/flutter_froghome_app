import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'record_list_controller.dart';

class RecordListView extends GetView<RecordListController> {
  const RecordListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async => await addRecord(context),
      ),
      body: controller.obx(
        (froglogs) => const Text('ddd'),
        onError: (msg) => const Center(
          child: Text(
            '開始調查GO!',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> addRecord(BuildContext context) async {
  final controller = Get.find<RecordListController>();
  controller.Add();
  // await Get.bottomSheet(
  //   backgroundColor: Colors.white,
  //   isScrollControlled: true,
  //   ignoreSafeArea: false,
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Obx(
      () => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '樣區',
                        prefixIcon: Icon(Icons.park_outlined),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      // value: controller.detail!.wind,
                      value: controller.editLog.plot.key,
                      isExpanded: true,
                      items: DBService.plot.values
                          .map<DropdownMenuItem<int>>(
                            (Plot plot) => DropdownMenuItem(
                              value: plot.key,
                              child: Text(plot.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => controller.editLog.plot = DBService
                          .plot.values
                          .firstWhere((element) => element.key == value),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: '調查日期',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      readOnly: true,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      controller: controller.dateCtrl,
                      onTap: () => showDatePicker(
                        context: context,
                        locale: const Locale('zh', 'TW'),
                        initialDate: controller.editLog.date,
                        firstDate:
                            Jiffy().startOf(Units.YEAR).add(years: -2).dateTime,
                        lastDate:
                            Jiffy().endOf(Units.YEAR).add(years: 1).dateTime,
                      ).then(
                        (value) {
                          controller.dateCtrl.text =
                              Jiffy(value).format('yyy-MM-dd');
                          ;
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
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
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
                                Jiffy(controller.editLog.stime).format('HH:mm');
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
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
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
                                Jiffy(controller.editLog.etime).format('HH:mm');
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
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 0,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
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
                      onChanged: (value) => controller.editLog.weather = value,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.thermostat),
                        labelText: '溫度',
                      ),
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
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
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
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
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
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
                style: TextStyle(
                  height: 1.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
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
                style: TextStyle(
                  height: 1.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                controller: controller.commentCtrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                child: Text('Save'),
                onPressed: () => controller.Save(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ),
  );
}
