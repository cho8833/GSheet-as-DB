import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Provider/TerminationNotiProvider.dart';

import '../../Constants/Constants.dart';

class Termination_CommitTableWidget extends StatefulWidget {
  const Termination_CommitTableWidget({Key? key}) : super(key: key);

  @override
  State<Termination_CommitTableWidget> createState() =>
      _Termination_CommitTableWidgetState();
}

class _Termination_CommitTableWidgetState
    extends State<Termination_CommitTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              "OutPut",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
        Flexible(
          flex: 7,
          fit: FlexFit.tight,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                width: 1,
              ),
            ),
            child: Consumer<TerminationNotiProvier>(
              builder: (context, provider, child) => ListView.builder(
                controller: ScrollController(),
                itemCount: provider.notifies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 1,
                      ),
                    ),
                    height: 50,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.notifies[index].member.phoneNumber,
                            style: Constants.itemTextStyle,
                          ),
                          Text(provider.notifies[index].member.name,
                              style: Constants.itemTextStyle),
                          Text(provider.notifies[index].moveInType,
                              style: Constants.itemTextStyle),
                          Text(
                            provider.notifies[index].date,
                            style: Constants.itemTextStyle,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                width: 1,
              ),
            ),
            child: Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    maximumSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    Provider.of<TerminationNotiProvier>(context, listen: false)
                        .commit();
                  },
                  child: Text("구글시트 다운로드")),
            ),
          ),
        ),
      ],
    );
  }
}
