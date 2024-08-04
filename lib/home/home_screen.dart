import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/home/settings/settings_tab.dart';
import 'package:todo_app/home/task_list/add_task_bottom_sheet.dart';
import 'package:todo_app/home/task_list/task_list_tab.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: MediaQuery.of(context).size.height*0.2,
        title: Text("To Do List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(2),
        shape: CircularNotchedRectangle(),
        notchMargin: 9,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
            onTap: (index){
            selectedIndex = index;
            setState(() {

            });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
              label: 'Task List'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(50)
        // ),
        onPressed: (){
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add ,  color: AppColors.whiteColor, size: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: AppColors.primaryColor,
          ),
          Expanded(
              child: selectedIndex == 0 ? TaskListTab() : SettingsTab())
        ],
      ),
    );
  }
  List<Widget> tabs = [TaskListTab(),SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => AddTaskBottomSheet()
    );
  }
}
