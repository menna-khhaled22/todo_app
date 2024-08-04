import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/task_list/edit_task_page.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/providers/list_provider.dart';

class TaskListItem extends StatefulWidget {
  Task task;
  TaskListItem({required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context){
                FirebaseUtils.deleteTaskFromFireStore(widget.task).timeout(
                  Duration(milliseconds: 500),onTimeout: (){
                    print('Task deleted successfully');
                    listProvider.getAllTasksFromFireStore();
                }
                );
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: () async {
            final updatedTask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskPage(task: widget.task),
              ),
            );
            if (updatedTask != null) {
              setState(() {
                widget.task.title = updatedTask.title;
                widget.task.description = updatedTask.description;
                widget.task.dateTime = updatedTask.date;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.whiteColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  color: isDone ?
                  AppColors.greenColor
                  :
                  AppColors.primaryColor,
                  width: width*0.01,
                  height: height*0.1,
                ),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(widget.task.title ,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDone ?
                      AppColors.greenColor
                          :
                      AppColors.primaryColor,
                    fontSize: 22
                  ),
                  ),
                  Text(widget.task.description,
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                ],
                )
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDone ?
                    AppColors.greenColor.withOpacity(0)
                        :
                    AppColors.primaryColor,
                  ),
                  child: isDone?
                      Text(
                        "Done!",
                        style: TextStyle(
                            color: AppColors.greenColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  :
                  IconButton(
                      onPressed: (){
                        setState(() {
                          isDone = true;
                        });
                      },
                      icon: Icon(Icons.check , size:  35 , color: AppColors.whiteColor,)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
