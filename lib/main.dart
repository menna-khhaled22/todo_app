import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // بدل dart:io
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// شاشات المشروع الأصلي
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/providers/auth_user_provider.dart';
import 'package:todo_app/providers/list_provider.dart';

// شاشات الملاحظات الجديدة
import 'screens/notes_list_screen.dart';
import 'screens/add_note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // إعداد Firebase للويب
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC_9Pe2QQnsC8y7ayLqptia9LAbi0jN9e8",
        appId: "1:896910991119:web:xxxxxxxxxxxxxxxx", // <-- عدليه من Firebase Console
        messagingSenderId: "896910991119",
        projectId: "todo-app-c1b2a",
      ),
    );
  } else {
    // إعداد Firebase لأندرويد / iOS
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => AuthUserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      theme: MyThemeData.LightTheme,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),

        // الشاشات الجديدة
        NotesListScreen.routeName: (context) => NotesListScreen(),
        AddNoteScreen.routeName: (context) => AddNoteScreen(),
      },
    );
  }
}

