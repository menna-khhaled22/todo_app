import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/providers/auth_user_provider.dart';
import 'package:todo_app/providers/list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {


  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override

  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Add new task",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey,
            child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              TextFormField(
                onChanged: (text){
                  title = text;
                },
                validator: (text){
                  if(text == null || text.isEmpty){
                    return "Please enter task title";   //invalid
                  }
                  return null;   //valid
                },
                decoration: InputDecoration(
                  hintText: "Enter task title"
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              TextFormField(
                onChanged: (text){
                  description = text;
                },
                validator: (text){
                  if(text == null || text.isEmpty){
                    return "Please enter task description";   //invalid
                  }
                  return null;   //valid
                },
                decoration: InputDecoration(
                    hintText: "Enter task Description"
                ),
                maxLines: 4,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Row(
                children: [
                  Text("Select Date",
                  textAlign: TextAlign.start ,
                  style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              InkWell(
                onTap: (){
                  showCalendar();
                },
                child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}" ,
                style: Theme.of(context).textTheme.bodySmall,),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,

                ),
                  onPressed: (){
                  addTask();
                  },
                  child: Text(
                    "Add",
                    style: Theme.of(context).textTheme.titleLarge,
                  ))
            ],
          ),
          ),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    selectedDate = chosenDate ?? selectedDate;
    setState(() {

    });
  }

  void addTask() {
    if(formKey.currentState?.validate() == true){

      Task task = Task(
          title: title,
          description: description,
          dateTime: selectedDate,
        isDone: true
      );

     var authProvider = Provider.of<AuthUserProvider>(context , listen: false);

      FirebaseUtils.addTaskToFireStore(task , authProvider.currentUser!.id!)
      .then((value) {
        print("Task added successfully!");
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      }
      )
          .timeout(Duration(seconds: 1),

      onTimeout: (){
        print("Task added successfully!");
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }


  }
}

