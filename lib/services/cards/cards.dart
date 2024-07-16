import 'dart:convert';

import 'package:ecom_mvvm/data/models/card_model.dart';
import 'package:flutter/services.dart';

class CardService {
  Future<List<CardModel>> loadCards() async {
    final String response =
        await rootBundle.loadString('assets/payments.json');
    final data = await json.decode(response);
    final cards = data['cards'] as List;
    return cards.map((json) => CardModel.fromJson(json)).toList();
  }
}
