// To parse this JSON data, do
//
//     final listSymbols = listSymbolsFromJson(jsonString);
// ignore_for_file: file_names

import 'dart:convert';

ListSymbols listSymbolsFromJson(String str) =>
    ListSymbols.fromJson(json.decode(str));

String listSymbolsToJson(ListSymbols data) => json.encode(data.toJson());

class ListSymbols {
  final String result;
  final List<String> symbols;

  ListSymbols({
    required this.result,
    required this.symbols,
  });

  factory ListSymbols.fromJson(Map<String, dynamic> json) => ListSymbols(
        result: json["result"],
        symbols: List<String>.from(json["symbols"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "symbols": List<dynamic>.from(symbols.map((x) => x)),
      };
}
