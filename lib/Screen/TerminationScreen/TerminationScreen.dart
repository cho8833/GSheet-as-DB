import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Provider/TerminationNotiProvider.dart';
import 'package:test_application/Screen/TerminationScreen/Termination_CommitTableWidget.dart';
import 'package:test_application/Screen/TerminationScreen/Termination_InputDataWidget.dart';
import '../../Provider/PostNotiProvider.dart';

class TerminationScreen extends StatefulWidget {
  const TerminationScreen({Key? key}) : super(key: key);

  @override
  State<TerminationScreen> createState() => _TerminationScreenState();
}

class _TerminationScreenState extends State<TerminationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TerminationNotiProvier(),
      child: Scaffold(
        body: Row(
          children: const [
            Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Termination_InputDataWidget()),
            Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Termination_CommitTableWidget()),
          ],
        ),
      ),
    );
  }
}
