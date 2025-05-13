import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/providers/auth_user_provider.dart';
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
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListProvider()),
        ChangeNotifierProvider(create: (_) => AuthUserProvider())
      ],
          child: MyApp(),
  ));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        RegisterScreen.routeName : (context) => RegisterScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
      },
      theme: MyThemeData.LightTheme,
      locale: Locale('ar'),
    );
  }
}