import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FrogItemWidget extends StatelessWidget {
  const FrogItemWidget({
    Key? key,
    required this.log,
    this.onEdit,
    this.onDelete,
    this.onAddItem,
    this.onMinuesItem,
  }) : super(key: key);
  final LogDetail log;
  final Function? onEdit;
  final Function? onDelete;
  final Function? onAddItem;
  final Function? onMinuesItem;

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
                  children: [
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(12),
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
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    Text(
                                      DBService.base.frogs[log.frog]!.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (DBService.base.frogs[log.frog]!.remove &
                                        log.remove)
                                      Text(
                                        '移',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${log.amount}',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (log.locTag != '') ...[
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade900,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    log.locTag,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: DBService
                                      .base.location[log.location]!.color,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${DBService.base.location[log.location]!.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      ' ${DBService.base.subLocation[log.subLocation]!.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (log.action != 9)
                                Container(
                                  padding: EdgeInsets.all(3),
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.indigoAccent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                      '${DBService.base.frogAction[log.action]!.name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      )),
                                ),
                            ],
                          ),
                          if (log.comment != '')
                            Row(
                              children: [
                                Expanded(
                                    child: Text(log.comment,
                                        style: TextStyle(fontSize: 14))),
                              ],
                            )
                        ],
                      ),
                    ),
                    IconButton(
                      iconSize: 36,
                      onPressed: () {
                        log.amount++;
                        log.save();
                      },
                      icon: Icon(Icons.add),
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
