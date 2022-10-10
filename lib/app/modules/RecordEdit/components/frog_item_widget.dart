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
      child: Card(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // spacing: 2,
                  // direction: Axis.vertical,
                  children: [
                    Row(
                      children: [
                        Text(
                          DBService.base.frogs[log.frog]!.name,
                          style: Theme.of(context).textTheme.headline6,
                          // style: const TextStyle(
                          //   fontSize: 24,
                          //   fontWeight: FontWeight.w600,
                          // ),
                          // overflow: TextOverflow.ellipsis,
                        ),
                        if (DBService.base.frogs[log.frog]!.remove & log.remove)
                          const Text(
                            '移除',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (log.locTag != -1 &&
                            log.locTag < plot.sub_location.length) ...[
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: 30,
                            decoration: BoxDecoration(
                              color: DBService.base.locColor[
                                  log.locTag! % DBService.base.locColor.length],
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
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                DBService.base.location[log.location]!.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (log.observed == 1)
                          Container(
                            padding: const EdgeInsets.all(3),
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              '聽音',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
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
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
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
                              style: const TextStyle(fontSize: 14),
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
    );
  }
}
