class Coin {
  final String id;
  final String symbol;
  final String name;
  final Images images;
  final MarketData marketData;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.images,
    required this.marketData,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json["id"],
      symbol: json["symbol"],
      name: json["name"],
      images: Images.fromJson(json["image"]),
      marketData: MarketData.fromJson(json["market_data"]),
    );
  }
}

class Images {
  final String thumb;
  final String small;
  final String large;

  const Images({required this.thumb, required this.small, required this.large});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      thumb: json["thumb"],
      small: json["small"],
      large: json["large"],
    );
  }
}

class MarketData {
  final num currPrice;
  final int marketCap;
  final int marketCapRank;

  const MarketData({
    required this.currPrice,
    required this.marketCap,
    required this.marketCapRank,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      currPrice: json["current_price"]["usd"],
      marketCap: json["market_cap"]["usd"],
      marketCapRank: json["market_cap_rank"],
    );
  }
}
