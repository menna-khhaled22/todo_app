import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/model/task.dart';
import 'package:intl/intl.dart';

class EditTaskPage extends StatefulWidget {

  Task task;

  EditTaskPage({required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _selectedDate = widget.task.dateTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    setState(() {
      widget.task.title = _titleController.text;
      widget.task.description = _descriptionController.text;
      widget.task.dateTime = _selectedDate;
    });
    Navigator.pop(context, widget.task);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: height*0.2,
        title: Text('To Do List',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white)
        ),
      ),
      body: Expanded(
        child: ListView(
          children:  [ Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: height*0.6,
              margin: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Edit Task',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title' ,
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),),
                    ),
                    SizedBox(height: height*0.02),
                    Row(
                      children: [
                        Text(
                          'Date: ${DateFormat('dd-MM-yyyy').format(_selectedDate)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: width*0.01),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select date' ,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.whiteColor
                          ),),
                          style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
                        ), ],
                    ),
                    SizedBox(height: height*0.02),
                    ElevatedButton(
                      onPressed: _saveTask,
                      child: Text('Save Changes' ,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.whiteColor
                        ),),
                      style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
            ]  ),
      ),

    );
  }
}

