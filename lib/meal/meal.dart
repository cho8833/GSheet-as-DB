import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

final formatter = DateFormat('yyyyMMdd');

class Meal {
  final List<String> breakfast;
  final List<String> lunch;
  final List<String> dinner;

  Meal({required this.breakfast, required this.lunch, required this.dinner});

  factory Meal.fromList(List<String> meals) {
    const noMealString = '급식이 없는 것 같아요 :(';
    List<String> breakfast = [];
    List<String> lunch = [];
    List<String> dinner = [];
    for (int i = 0; i < meals.length; i++) {
      List<String> temp = [];

      if (meals[i] == '') {
        temp.add(noMealString);
      } else {
        temp = meals[i]
            .replaceAll(RegExp(r"[0-9.*.).(.]"), "")
            .replaceAll(' ', "")
            .split('<br/>');
        
      }
      switch (i) {
        case 1:
          breakfast = temp;
          break;
        case 2:
          lunch = temp;
          break;
        case 3:
          dinner = temp;
      }
    }
    return Meal(breakfast: breakfast, lunch: lunch, dinner: dinner);
  }
}

Future<Meal> fetchMeal(String mscode, String sccode, String ymd) async {
  final res = await http.get(Uri.parse(
      "https://open.neis.go.kr/hub/mealServiceDietInfo?ATPT_OFCDC_SC_CODE=$mscode&SD_SCHUL_CODE=$sccode&Type=meal&KEY=76ebe67f34c44b7ba5c10ac9f3b4060e&MLSV_YMD=$ymd&Type=json"));
  // response
  if (res.statusCode == 200) {
    var jsonBody = json.decode(res.body);
    // if meal exist
    if (jsonBody['mealServiceDietInfo'][0]['head'][1]["RESULT"]["CODE"] ==
        'INFO-000') {
      List<String> meals = ['', '', ''];
      for (var dishInfo in jsonBody['mealServiceDietInfo'][1]['row']) {
        meals[int.parse(dishInfo['MMEAL_SC_CODE']) - 1] = dishInfo['DDISH_NM'];
      }
      return Meal.fromList(meals);
    } else if (jsonBody["RESULT"]["CODE"] == 'INFO-200') {
      return Meal.fromList(['', '', '']);
    }
  }
  return Meal.fromList(['', '', '']);
}
