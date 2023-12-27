import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';

import '../constants/api.dart';
import '../models/coin.dart';

class CoinGeckoProvider extends ChangeNotifier {
  final List<Coin> _coins = [];

  List<Coin> get coins => _coins;

  void getCoinList() async {
    Response response;

    try {
      response = await http.get(Uri.parse(baseUrl));

      for (Map<String, dynamic> obj in jsonDecode(response.body)) {
        _coins.add(Coin.fromJson(obj));
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
