import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/coin.dart';

class CoinsDataProvider extends ChangeNotifier {
  final List<Coin> _coins = [];

  List<Coin> get coins => _coins;

  Future<void> getCoinList() async {
    try {
      final response = await http.get(Uri.parse(coinOverViewListApi));
      final listCoin = jsonDecode(response.body)["data"];

      for (Map<String, dynamic> obj in listCoin) {
        final coinDetails =
            await _getCoinDetails(Coin.fromJson(obj), Coin.fromJson(obj).id);
        _coins.add(coinDetails);
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 1500));
      }
    } catch (e) {
      print("Error at getCoinList()");
    }
  }

  Future<Coin> _getCoinDetails(Coin coin, int id) async {
    try {
      final response = await http.get(Uri.parse("$coinDetailApi$id"));

      coin.setLogo(jsonDecode(response.body)["data"]["$id"]["logo"]);
      return coin;
    } catch (e) {
      throw Exception("Error at get coin details");
    }
  }
}
