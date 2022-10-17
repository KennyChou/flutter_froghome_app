import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FrogItemWidget extends StatelessWidget {
  FrogItemWidget({
    Key? key,
    required this.log,
    required this.plot,
    this.onEdit,
    this.onDelete,
    this.onAddItem,
    this.onMinuesItem,
    this.onChangeAmount,
    this.editColor,
  }) : super(key: key);
  final LogDetail log;
  final Plot plot;
  final Function? onEdit;
  final Function? onDelete;
  final Function? onAddItem;
  final Function? onMinuesItem;
  ValueChanged<int>? onChangeAmount;
  final Color? editColor;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onEdit!(),
            backgroundColor: Colors.green,
            icon: Icons.edit,
            label: '編輯',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: '刪除',
            onPressed: (context) => onDelete!(),
          ),
        ],
      ),
      child: Card(
        color: editColor,
        elevation: 2,
        margin: const EdgeInsets.fromLTRB(7, 4, 7, 5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: DBService.base.sex[log.sex]!.color,
                  ),
                  onPressed: () => onChangeAmount!(-1),
                  child: Text(
                    DBService.base.sex[log.sex]!.nickName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .merge(const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Text(
                          DBService.base.frogs[log.frog]!.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (DBService.base.frogs[log.frog]!.remove &
                            log.remove) ...[
                          const SizedBox(width: 10),
                          Text(
                            '移除',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .merge(const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      runSpacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (log.locTag != -1 &&
                            log.locTag < plot.sub_location.length) ...[
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: 30,
                            decoration: BoxDecoration(
                              color: DBService.base.locColor[
                                  log.locTag % DBService.base.locColor.length],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              plot.sub_location[log.locTag],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: DBService.base.location[log.location]!.color,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              Text(
                                ' ${DBService.base.subLocation[log.subLocation]!.name}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                DBService.base.location[log.location]!.name,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        if (log.observed == 1)
                          Container(
                            padding: const EdgeInsets.all(3),
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              '聽音',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (log.action != 9 && log.observed != 1)
                          Container(
                            padding: const EdgeInsets.all(3),
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              DBService.base.frogAction[log.action]!.name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (log.comment != '')
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              log.comment,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .merge(const TextStyle(color: Colors.black)),
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80,
                child: TextButton(
                  child: Text(
                    '${log.amount}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  onPressed: () => onChangeAmount!(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
