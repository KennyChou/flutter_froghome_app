import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/record_edit_controller.dart';
import 'package:get/get.dart';

class FrogEditWidget extends StatelessWidget {
  FrogEditWidget({
    Key? super.key,
    required this.onSave,
    required this.onCancel,
  });

  final Function onSave;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    return GetX<RecordEditController>(
        init: RecordEditController(),
        builder: (_c) {
          final log = _c.current;
          final plot = _c.plot;
          var textStyle = TextStyle(
            fontSize: 18,
            height: 1.0,
            color: Theme.of(context).colorScheme.onBackground,
          );
          return Wrap(
            children: [
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  "移除",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                value: log!.remove,
                onChanged: (bool? value) {
                  print(value);
                  _c.current!.remove = value!;
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: '蛙種',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                iconSize: 0,
                style: textStyle,
                value: log!.frog,
                isExpanded: true,
                items: plot!.frogs
                    .map<DropdownMenuItem<int>>(
                      (int frog) => DropdownMenuItem(
                        value: frog,
                        child: Text(DBService.base.frogs[frog]!.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  log!.frog = value!;
                },
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
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text('確定'),
                        onPressed: () {
                          onSave();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
