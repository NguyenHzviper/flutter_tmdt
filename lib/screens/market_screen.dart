import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/coin_gecko_provider.dart';
import '../widgets/coin_tile.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CoinGeckoProvider>(context, listen: false).getCoinList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CoinGeckoProvider>(
        builder: (context, coinGeckoProvider, child) {
          final coinList = coinGeckoProvider.coins;

          if (coinList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 4, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "#",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Market Cap",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "24h %",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: coinList.length,
                      itemBuilder: (context, index) {
                        final coin = coinList[index];
                        return CoinTile(index: index + 1, coin: coin);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
