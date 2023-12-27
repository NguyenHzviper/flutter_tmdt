import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:price_alert/models/coin.dart';

class CoinTile extends StatelessWidget {
  final int index;
  final Coin coin;

  const CoinTile({super.key, required this.index, required this.coin});

  @override
  Widget build(BuildContext context) {
    final name = coin.name;
    final image = coin.images.thumb;
    final currPrice = NumberFormat.simpleCurrency(
      locale: 'en-US',
      decimalDigits: 2,
    ).format(coin.marketData.currPrice);
    final marketCap = NumberFormat.compactSimpleCurrency(
      locale: 'en-US',
      decimalDigits: 3,
    ).format(coin.marketData.marketCap);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$index"),
          const SizedBox(
            width: 16,
          ),
          CircleAvatar(
            child: Image.network(image),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(marketCap)
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Text(currPrice)
        ],
      ),
    );
  }
}
