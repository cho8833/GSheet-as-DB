import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/GSheet_REST/GSheet.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';

class Main2 extends StatelessWidget {
  Main2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
