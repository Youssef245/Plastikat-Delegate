import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plastikat_delegate/Login.dart';
import '../Pages/HomePage.dart';
void main () async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Login(false),));
}


