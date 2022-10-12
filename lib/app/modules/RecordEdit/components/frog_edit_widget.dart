import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/RecordEdit/record_edit_controller.dart';
import 'package:get/get.dart';

class FrogEditWidget extends StatelessWidget {
  const FrogEditWidget({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  final RecordEditController controller;
  final Function onSave;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    final frogInputTextStyle = Theme.of(context).textTheme.bodyLarge!;

    return GetBuilder<RecordEditController>(
        init: RecordEditController(),
        builder: (c) {
          final log = c.editLog.value;
          final plot = c.plot;

          if (plot.sub_location.isNotEmpty) {
            if (log.locTag > plot.sub_location.length || log.locTag == -1) {
              log.locTag = 0;
            }
          } else {
            log.locTag = -1;
          }

          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      if (DBService.base.frogs[log.frog]!.remove)
                        Flexible(
                          flex: 2,
                          child: FrogRemoveCheckbox(
                            log: log,
                            onChanged: (value) {
                              log.remove = value;
                              c.update();
                            },
                          ),
                        ),
                      Flexible(
                        flex: 5,
                        child: FrogField(
                          frogInputTextStyle: frogInputTextStyle,
                          log: log,
                          plot: plot,
                          onChanged: (value) {
                            log.frog = value;
                            log.remove = DBService.base.frogs[log.frog]!.remove;
                            log.location =
                                DBService.base.frogs[log.frog]!.location;
                            log.subLocation =
                                DBService.base.frogs[log.frog]!.subLocation;
                            c.update();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 2,
                        child: SexField(
                          frogInputTextStyle: frogInputTextStyle,
                          log: log,
                          onChanged: (value) {
                            log.sex = value;
                            c.update();
                          },
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
                        child: LocationField(
                          frogInputTextStyle: frogInputTextStyle,
                          value: log.location,
                          onChanged: (value) {
                            log.location = value;
                            log.subLocation = DBService
                                .base.location[value]!.defaultSubLocation;
                            c.update();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: SubLocationField(
                          frogInputTextStyle: frogInputTextStyle,
                          log: log,
                          onChanged: (value) {
                            log.subLocation = value;
                            c.update();
                          },
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
                        child: ObservedField(
                          frogInputTextStyle: frogInputTextStyle,
                          value: log.observed,
                          onChanged: (value) {
                            log.observed = value;
                            if (log.observed == 1) {
                              log.action = 3;
                            }
                            c.update();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: FrogActionField(
                          frogInputTextStyle: frogInputTextStyle,
                          log: log,
                          onChanged: (value) {
                            log.action = value!;
                            c.update();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: c.amountCtrl,
                          decoration: InputDecoration(
                            labelText: '數量',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => c.amountCtrl.text =
                                  (int.parse(c.amountCtrl.text) + 1).toString(),
                            ),
                          ),
                          style: frogInputTextStyle,
                          keyboardType: TextInputType.number,
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
                          controller: c.commentCtrl,
                          decoration: const InputDecoration(
                            labelText: '備註',
                            prefixIcon: Icon(Icons.comment),
                          ),
                          style: frogInputTextStyle,
                        ),
                      ),
                      if (plot.sub_location.isNotEmpty) ...[
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: LocSubField(
                            frogInputTextStyle: frogInputTextStyle,
                            log: log,
                            plot: plot,
                            onChanged: (value) {
                              log.locTag = value;
                              c.update();
                            },
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
                        plot.tags.length,
                        (index) => ActionChip(
                          elevation: 6.0,
                          label: Text(plot.tags[index]),
                          onPressed: () {
                            if (c.commentCtrl.text.trim() == '') {
                              c.commentCtrl.text = plot.tags[index];
                            } else {
                              final words = c.commentCtrl.text.split(',');
                              if (!words.contains(plot.tags[index])) {
                                words.add(plot.tags[index]);
                                c.commentCtrl.text = words.join(',');
                              }
                            }
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
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
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
                            log.comment = c.commentCtrl.text;
                            log.amount = int.parse(c.amountCtrl.text);
                            onSave();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class LocSubField extends StatelessWidget {
  LocSubField({
    Key? key,
    required this.frogInputTextStyle,
    required this.log,
    required this.plot,
    required this.onChanged,
  }) : super(key: key);

  final TextStyle frogInputTextStyle;
  final LogDetail log;
  final Plot plot;
  ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '子樣區',
          // prefixIcon:Icon(Icons.scatter_plot_outlined, size: 14),
          suffixIcon: Icon(Icons.arrow_drop_down),
        ),
        iconSize: 0,
        style: frogInputTextStyle,
        value: log.locTag,
        isExpanded: true,
        items: plot.sub_location
            .asMap()
            .entries
            .map<DropdownMenuItem<int>>(
              (e) => DropdownMenuItem(
                value: e.key,
                child: Text(e.value),
              ),
            )
            .toList(),
        onChanged: (int? value) => onChanged(value!));
  }
}

class FrogActionField extends StatelessWidget {
  FrogActionField({
    Key? key,
    required this.frogInputTextStyle,
    required this.log,
    required this.onChanged,
  }) : super(key: key);

  final TextStyle frogInputTextStyle;
  final LogDetail log;
  ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: '成體型為',
      ),
      style: frogInputTextStyle,
      value: (log.observed == 1) ? 3 : log.action,
      isExpanded: true,
      items: (log.observed == 1)
          ? [
              DropdownMenuItem(
                  value: 3, child: Text(DBService.base.frogAction[3]!.name))
            ].toList()
          : DBService.base.frogAction.entries
              .map<DropdownMenuItem<int>>(
                (e) => DropdownMenuItem(
                  value: e.key,
                  child: Text(e.value.name),
                ),
              )
              .toList(),
      onChanged: (value) => onChanged(value!),
    );
  }
}

class ObservedField extends StatelessWidget {
  ObservedField({
    Key? key,
    required this.frogInputTextStyle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final TextStyle frogInputTextStyle;
  final int value;
  ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: '觀察',
      ),
      style: frogInputTextStyle,
      value: value,
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
      onChanged: (value) => onChanged(value!),
    );
  }
}

class SubLocationField extends StatelessWidget {
  SubLocationField({
    Key? key,
    required this.frogInputTextStyle,
    required this.log,
    required this.onChanged,
  }) : super(key: key);

  final TextStyle frogInputTextStyle;
  final LogDetail log;
  ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '子棲地',
        ),
        style: frogInputTextStyle,
        value: log.subLocation,
        isExpanded: true,
        items: DBService.base.subLocation.entries
            .where((e) => e.value.location == log.location)
            .map<DropdownMenuItem<int>>(
              (e) => DropdownMenuItem(
                value: e.key,
                child: Text(e.value.name),
              ),
            )
            .toList(),
        onChanged: (value) => onChanged(value!));
  }
}

class LocationField extends StatelessWidget {
  LocationField({
    Key? key,
    required this.frogInputTextStyle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final TextStyle frogInputTextStyle;
  final int value;
  ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: '棲地類型',
      ),
      style: frogInputTextStyle,
      value: value,
      isExpanded: true,
      items: DBService.base.location.entries
          .map<DropdownMenuItem<int>>(
            (e) => DropdownMenuItem(
              value: e.key,
              child: Text(e.value.name),
            ),
          )
          .toList(),
      onChanged: (value) => onChanged(value!),
    );
  }
}

class SexField extends StatelessWidget {
  SexField({
    Key? key,
    required this.frogInputTextStyle,
    required this.log,
    required this.onChanged,
  }) : super(key: key);

  final TextStyle frogInputTextStyle;
  final LogDetail log;
  ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: '型態',
      ),

      style: frogInputTextStyle,
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
      onChanged: (value) => onChanged(value!),
    );
  }
}

class FrogField extends StatelessWidget {
  FrogField({
    Key? key,
    required this.frogInputTextStyle,
    required this.log,
    required this.plot,
    required this.onChanged,
  }) : super(key: key);

  final TextStyle frogInputTextStyle;
  final LogDetail log;
  final Plot plot;
  ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: '蛙種',
      ),
      style: frogInputTextStyle,
      value: log.frog,
      isExpanded: true,
      items: plot.frogs
          .map<DropdownMenuItem<int>>(
            (int frog) => DropdownMenuItem(
              value: frog,
              child: Text(DBService.base.frogs[frog]!.name),
            ),
          )
          .toList(),
      onChanged: (value) => onChanged(value!),
    );
  }
}

class FrogRemoveCheckbox extends StatelessWidget {
  FrogRemoveCheckbox({
    Key? key,
    required this.log,
    required this.onChanged,
  }) : super(key: key);

  final LogDetail log;
  ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text(
        "移除",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
      value: log.remove,
      onChanged: (value) => onChanged(value!),
    );
  }
}
