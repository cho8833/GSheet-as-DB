import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'meal/meal.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    fetchMeal('S10', '9010066', DateFormat('yyyyMMdd').format(DateTime.now()))
        .then((value) {
      print(value.breakfast);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
