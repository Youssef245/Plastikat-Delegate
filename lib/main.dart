import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plastikat_delegate/Login.dart';
import '../Pages/HomePage.dart';
import 'globals.dart' as globals;
void main () async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? logged = await globals.user.read(key: "login");
  if(logged=="true")
    runApp(MaterialApp(home: HomePage(),));
  else
    runApp(MaterialApp(home: Login(false),));
}


