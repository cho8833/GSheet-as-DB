import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';
import 'package:test_application/Model/HistoryModel.dart';
import 'package:test_application/Repository/HistoryRepository/GSheetsHistoryRepository.dart';

import 'GSheetHistoryRepositoryTest.mocks.dart';

class MockHistory extends Mock implements History {}

class MockSpreadsheet extends Mock implements Spreadsheet {}

@GenerateMocks([GSheetsHistoryRepository])
void main() {
  late MockGSheetsHistoryRepository mockRepository;
  setUpAll(() { 
    mockRepository = MockGSheetsHistoryRepository();
  });

  test('test appendData', () async {
    History history = MockHistory();
    when(mockRepository.appendData([history]))
        .thenAnswer((realInvocation) async {
      return true;
    });
    final res = await mockRepository.appendData([history]);
    expect(res, isA<bool>());
    expect(res, true);
  });
}
