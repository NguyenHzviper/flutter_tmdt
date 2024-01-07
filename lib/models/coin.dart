class Coin {
  final int id;
  final String name;
  final String symbol;
  final double? currPice;
  final double? marketCap;
  late String logo;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    this.currPice,
    this.marketCap,
  });

  void setLogo(String logo) {
    this.logo = logo;
  }

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json["id"] as int,
      name: json["name"],
      symbol: json["symbol"],
      currPice: json["quote"]["USD"]["price"],
      marketCap: json["quote"]["USD"]["market_cap"],
    );
  }
}
