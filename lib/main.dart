import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/providers/list_provider.dart';
void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC_9Pe2QQnsC8y7ayLqptia9LAbi0jN9e8",
        appId: "com.example.todo_app",
        messagingSenderId: "896910991119",
        projectId: "todo-app-c1b2a"
    )
  )
      :
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),

      },
      theme: MyThemeData.LightTheme,
    );
  }
}