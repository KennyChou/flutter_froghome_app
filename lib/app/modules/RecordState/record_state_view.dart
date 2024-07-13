import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

import 'record_state_controller.dart';

class RecordStateView extends GetView<RecordStateController> {
  const RecordStateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('統計資料'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: controller.statFamily.length,
          itemBuilder: (BuildContext context, int index) {
            final family = controller.statFamily[index];
            final frogs = DBService.base.frogs.entries
                .where((e) =>
                    controller.frog.containsKey(e.key) &&
                    e.value.family == family)
                .toList();
            print(frogs);
            return Column(
              children: [
                Text(DBService.base.family[family]!.name),
                ...frogs
                    .map(
                      (e) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.value.name,
                          ),
                          Row(
                            children: [
                              const Text('目擊'),
                              Text(controller.frog[e.key]!['watch'].toString()),
                              const Text(' 聽音'),
                              Text(controller.frog[e.key]!['hea'].toString()),
                              if (e.value.remove) ...[
                                const Text(' 移除'),
                                Text(controller.frog[e.key]!['remove']
                                    .toString()),
                              ],
                              // Text(controller.frog[e.key]!['qty'].toString()),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList()
              ],
            );
          },
        ),
      ),
    );
  }
}
