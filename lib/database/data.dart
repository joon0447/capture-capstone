import 'package:capture/database/category_api.dart';

class CategoryData {
  static Map<String, List<dynamic>> data = {};

  static void updateUseData(String use, List<dynamic> newData) {
    data[use] = newData;
  }

  static List<dynamic> getAllData() {
    List<dynamic> allData = [];
    data.forEach((key, value) {
      allData.addAll(value);
    });
    return allData;
  }

  static List<dynamic> getUseData(String use) {
    print(data[use]);
    return data[use] ?? [];
  }

  static Future<void> loadCategoryData(String use) async {
    final value = await CategoryApi.getUseData(use: use);
    updateUseData(use, value);
  }
}
