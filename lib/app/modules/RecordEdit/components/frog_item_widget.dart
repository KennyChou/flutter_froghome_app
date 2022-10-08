import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FrogItemWidget extends StatelessWidget {
  const FrogItemWidget({
    Key? key,
    required this.log,
    required this.plot,
    this.onEdit,
    this.onDelete,
    this.onAddItem,
    this.onMinuesItem,
    this.locColor,
  }) : super(key: key);
  final LogDetail log;
  final Plot plot;
  final Function? onEdit;
  final Function? onDelete;
  final Function? onAddItem;
  final Function? onMinuesItem;
  final Color? locColor;

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
            onPressed: (context) => onDelete!(),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: '刪除',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: DBService.base.sex[log.sex]!.color,
                        ),
                        onPressed: () {
                          if (log.amount > 1) {
                            log.amount--;
                            log.save();
                          }
                        },
                        child: Text(
                          DBService.base.sex[log.sex]!.nickName,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                DBService.base.frogs[log.frog]!.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (DBService.base.frogs[log.frog]!.remove &
                                  log.remove)
                                const Text(
                                  '移',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              if (log.locTag != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: DBService.base.locColor[log.locTag! %
                                        DBService.base.locColor.length],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    plot!.sub_location[log.locTag!],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: DBService
                                      .base.location[log.location]!.color,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      DBService
                                          .base.location[log.location]!.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      ' ${DBService.base.subLocation[log.subLocation]!.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (log.action != 9) ...[
                                const SizedBox(width: 10),
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
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (log.comment != '')
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    log.comment,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: TextButton(
                        child: Text(
                          '${log.amount}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          log.amount++;
                          log.save();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
