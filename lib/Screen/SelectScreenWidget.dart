import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Provider/StatusProvider.dart';
import '../Constants/Constants.dart';

class SelectScreenWidget extends StatelessWidget {
  const SelectScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusProvider statusProvider = Provider.of<StatusProvider>(context);

    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),
              ),
              onPressed: () {
                statusProvider.screenType = ScreenType.postScreen;
              },
              child: const Text(Constants.postButtonTitle)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),
              ),
              onPressed: () {
                statusProvider.screenType = ScreenType.terminationScreen;
              },
              child: const Text(Constants.terminationButtonTitle)),
        ],
      ),
    );
  }
}
