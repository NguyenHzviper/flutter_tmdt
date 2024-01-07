import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/coins_data_provider.dart';
import '../widgets/coin_table.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CoinsDataProvider>(context, listen: false).getCoinList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CoinsDataProvider>(
        builder: (context, coinGeckoProvider, child) {
          final coinList = coinGeckoProvider.coins;

          if (coinList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: CoinTable(data: coinList),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
