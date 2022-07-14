import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Model/HistoryModel.dart';
import 'package:test_application/Provider/HistoryProvider.dart';
import 'package:test_application/Provider/MemberProvider.dart';

import 'Model/MemberModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Spreadsheet memberSpreadsheet = await GSheetsAPIConfig.gSheets
      .spreadsheet(GSheetsAPIConfig.MEMBER_SPREAD_ID);
  Spreadsheet historySpreadsheet = await GSheetsAPIConfig.gSheets
      .spreadsheet(GSheetsAPIConfig.HISTORY_SPREAD_ID);
  runApp(Main(
    memberSpreadsheet: memberSpreadsheet,
    historySpreadsheet: historySpreadsheet,
  ));
}

@immutable
class Main extends StatelessWidget {
  late Spreadsheet memberSpreadsheet;
  late Spreadsheet historySpreadsheet;

  Main(
      {Key? key,
      required this.memberSpreadsheet,
      required this.historySpreadsheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiProvider(providers: [
      ChangeNotifierProvider<MemberProvider>(
        create: (_) => MemberProvider(memberSpreadsheet),
      ),
      ChangeNotifierProvider<HistoryProvider>(
        create: (_) => HistoryProvider(historySpreadsheet),
      )
    ], child: const App()));
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Member> memberList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MemberProvider memberProvider = context.watch<MemberProvider>();
    HistoryProvider historyProvider = context.watch<HistoryProvider>();
    return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemBuilder: (context, index) {
                      return SizedBox(
                        child: Row(
                          children: [
                            Text(memberProvider.memberList[index].name),
                            Text(memberProvider.memberList[index].phoneNumber)
                          ],
                        ),
                      );
                },
                itemCount: memberProvider.memberList.length,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                historyProvider.addHistory(History(name: memberProvider.memberList[0].name, phoneNumber: memberProvider.memberList[0].phoneNumber));
              },
              child: const Text("add")
            )
          ],
        ));
  }
}
