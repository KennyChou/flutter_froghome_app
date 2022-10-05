import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';

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
  await Get.bottomSheet(
    backgroundColor: Colors.white,
    Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: '樣區',
                        prefixIcon: Icon(Icons.air),
                        suffixIcon: Icon(Icons.arrow_drop_down)),
                    iconSize: 0,
                    style: TextStyle(
                      height: 1.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    // value: controller.detail!.wind,
                    isExpanded: true,
                    items: DBService.plot.values
                        .map<DropdownMenuItem<int>>(
                          (Plot plot) => DropdownMenuItem(
                            value: plot.key,
                            child: Text(plot.name),
                          ),
                        )
                        .toList(),
                    onChanged: (int? value) => print(value),
                    validator: (value) => value == null ? '必須選取' : null,
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
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
                    // controller: controller.dateController,
                    onTap: () => showDatePicker(
                      context: context,
                      locale: const Locale('zh', 'TW'),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2023),
                      // initialDate: controller.bbslog!.date,
                      // firstDate: Jiffy().startOf(Units.YEAR).dateTime,
                      // lastDate: Jiffy().endOf(Units.YEAR).dateTime,
                    ).then(
                      (value) {
                        print(value);
                        // controller.dateController.text =
                        //     Jiffy(value).format('yyyy-MM-dd');
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
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: '調查日期',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    style: TextStyle(
                      height: 1.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: '調查日期',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    style: TextStyle(
                      height: 1.0,
                      color: Theme.of(context).colorScheme.onBackground,
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
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: '調查日期',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    style: TextStyle(
                      height: 1.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: '調查日期',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    style: TextStyle(
                      height: 1.0,
                      color: Theme.of(context).colorScheme.onBackground,
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
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: '調查日期',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    style: TextStyle(
                      height: 1.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: '調查日期',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    style: TextStyle(
                      height: 1.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: '調查日期',
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              style: TextStyle(
                height: 1.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: '調查日期',
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              style: TextStyle(
                height: 1.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () => print('add'),
            ),
          ),
        ],
      ),
    ),
  );
}
