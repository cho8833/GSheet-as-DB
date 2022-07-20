import 'package:flutter/material.dart';

enum ScreenType { postScreen, terminationScreen }

enum Status { idle, loading, fail, success }

class StatusProvider extends ChangeNotifier {
  ScreenType _screenType = ScreenType.postScreen;
  Status _status = Status.idle;

  set screenType(ScreenType screenType) {
    _screenType = screenType;
    notifyListeners();
  }

  set status(Status status) {
    _status = status;
    notifyListeners();
  }

  ScreenType get screenType => _screenType;
}
