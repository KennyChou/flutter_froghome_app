import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
            const Card(
              child: ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    labelText: '樣區名稱',
                  ),
                ),
              ),
            ),
            MultiSelectDialogField(
              buttonText: Text('可能蛙種'),
              title: Text('選取蛙種'),
              // itemsTextStyle: TextStyle(color: Colors.white),
              items: DBService.base.frogs
                  .map((frog) => MultiSelectItem(frog.id, frog.name))
                  .toList(),
              onConfirm: (List<dynamic> values) {
                print(values);
              },
            ),
            Chip(
              label: Text('fsdsd'),
              deleteIcon: Icon(Icons.close),
              onDeleted: () => print('fsd'),
              // labelStyle: TextStyle(color: Colors.white),
            ),
            // Card(
            //   child: SmartSelect<int>.multiple(
            //       title: '可能蛙種',
            //       // placeholder: '請選擇',
            //       selectedValue: [2],
            //       choiceItems: DBService.base.frogs
            //           .map((frog) => S2Choice(value: frog.id, title: frog.name))
            //           .toList(),
            //       // modalType: S2ModalType.bottomSheet,
            //       choiceDirection: Axis.vertical,
            //       onChange: (state) => print(state)),
            // ),
          ],
        ),
      ),
    );
  }
}
