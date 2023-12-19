// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:price_alert/models/backtest_model.dart';
import 'package:intl/intl.dart';

class BacktestResultScreen extends StatelessWidget {
  final Backtest result;

  const BacktestResultScreen({Key? key, required this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,000');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backtest Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultItem(
                  "Start fund", formatter.format(1000000) + ' USD'),
              _buildResultItem("Traing pair", result.output.tradingPair),
              _buildResultItem("Indicator name", result.output.nameIndicator),
              _buildResultItem("MA long term", result.output.maLength1),
              _buildResultItem("MA short term", result.output.maLength2),
              _buildResultItem("Win rate percent",
                  result.output.winRatePercent.round().toString() + '%'),
              _buildResultItem("Return Percent",
                  result.output.returnPercent.round().toString() + '%'),
              _buildResultItem("Equity Final",
                  formatter.format(result.output.equityFinal) + ' USD'),
              _buildResultItem("Equity Peak",
                  formatter.format(result.output.equityPeak) + ' USD'),
              _buildResultItem("Max Drawdown Percent",
                  result.output.maxDrawdownPercent.round().toString() + '%'),
              _buildResultItem("Trade Count", result.output.tradesCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value.toString()), // Convert value to string or format as needed
        ],
      ),
    );
  }
}
