import 'package:flutter/material.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'components/log_input_widget.dart';
import 'record_edit_controller.dart';

class RecordEditView extends GetView<RecordEditController> {
  const RecordEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (frogLog) => Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => const <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Download'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('State'),
                ),
                PopupMenuDivider(height: 1),
                PopupMenuItem(
                  value: 2,
                  child: Text('Clear'),
                ),
              ],
              onSelected: (value) {
                print(value);
              },
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    DBService.plot.getName(frogLog!.plot),
                  ),
                ),
              ),
              Text(
                Jiffy(frogLog.date).format('yyyy-MM-dd'),
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showEditLog(context, null),
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: DBService.logs.values.length,
            itemBuilder: (context, index) {
              final log = DBService.logs.values[index];
              return ListTile(title: Text(DBService.base.frogName[log.frog]!));
            },
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    onPressed: () => print('add'),
                    child: Text(
                      '公',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              '盤古蟾蜍',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            '6',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text('樹木-灌木')),
                          SizedBox(width: 10),
                          Text('action'),
                          SizedBox(width: 10),
                          Expanded(child: Text('備註')),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 36,
                    onPressed: () => print('dddd'),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showEditLog(BuildContext context, LogDetail? log) async {
  final controller = Get.find<RecordEditController>();
  if (log == null) {
    controller.Add();
  } else {
    controller.Edit(log);
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => SingleChildScrollView(
      child: LogInputWidget(
        onCancel: () => Navigator.pop(context),
        onSave: () {
          controller.Save();
        },
      ),
    ),
  );
}
