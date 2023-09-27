import 'dart:convert';

import 'package:fit_fusion/data/models/quote_model.dart';
import 'package:http/http.dart';

final class QuoteRepository {
  Future<QuoteModel> getQuotes() async {
    final respose = await get(Uri.parse('https://dummyjson.com/quotes'));

    if (respose.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(respose.body));
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
