import 'dart:math';

import 'package:sparta/pages/_shared/models/categories_json.dart';
import 'package:sparta/pages/_shared/network/_http_client.dart';

//final response = await client.get('$_host/$_path');

class CategoriesHttpClient {
  const CategoriesHttpClient(this.client);

  final HttpClient client;

  Future<List<CategoryJson>> fetchCategories() async {
    // TODO(albert): remove
    await Future<void>.delayed(const Duration(seconds: 1));
    return CategoriesJson.fromJson(_categories).categories;
  }
}

Map<String, dynamic> get _categories {
  final random = Random();
  return {'categories': List.generate(2, (i) => _category(i, random))};
}

Map<String, dynamic> _category(int i, Random random) => {
      'id': '$i',
      'title': 'Title $i',
      'color': i == 0 ? 'e53935' : '000000',
    };
