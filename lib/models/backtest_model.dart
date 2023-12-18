// To parse this JSON data, do
//
//     final backtest = backtestFromJson(jsonString);

import 'dart:convert';

Backtest backtestFromJson(String str) => Backtest.fromJson(json.decode(str));

String backtestToJson(Backtest data) => json.encode(data.toJson());

class Backtest {
  final Output output;
  final String result;

  Backtest({
    required this.output,
    required this.result,
  });

  factory Backtest.fromJson(Map<String, dynamic> json) => Backtest(
        output: Output.fromJson(json["output"]),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "output": output.toJson(),
        "result": result,
      };
}

class Output {
  final int avgDrawdownDuration;
  final double avgDrawdownPercent;
  final int avgTradeDuration;
  final double avgTradePercent;
  final double bestTradePercent;
  final double buyAndHoldReturnPercent;
  final double calmarRatio;
  final int duration;
  final int endDay;
  final double equityFinal;
  final double equityPeak;
  final double exposureTimePercent;
  final int maLength1;
  final int maLength2;
  final int maxDrawdownDuration;
  final double maxDrawdownPercent;
  final int maxTradeDuration;
  final String nameIndicator;
  final double profitFactor;
  final double returnAnnualizedPercent;
  final double returnPercent;
  final double sharpeRatio;
  final double sortinoRatio;
  final int startDay;
  final int tradesCount;
  final String tradingPair;
  final double volatilityAnnualizedPercent;
  final double winRatePercent;
  final double worstTradePercent;

  Output({
    required this.avgDrawdownDuration,
    required this.avgDrawdownPercent,
    required this.avgTradeDuration,
    required this.avgTradePercent,
    required this.bestTradePercent,
    required this.buyAndHoldReturnPercent,
    required this.calmarRatio,
    required this.duration,
    required this.endDay,
    required this.equityFinal,
    required this.equityPeak,
    required this.exposureTimePercent,
    required this.maLength1,
    required this.maLength2,
    required this.maxDrawdownDuration,
    required this.maxDrawdownPercent,
    required this.maxTradeDuration,
    required this.nameIndicator,
    required this.profitFactor,
    required this.returnAnnualizedPercent,
    required this.returnPercent,
    required this.sharpeRatio,
    required this.sortinoRatio,
    required this.startDay,
    required this.tradesCount,
    required this.tradingPair,
    required this.volatilityAnnualizedPercent,
    required this.winRatePercent,
    required this.worstTradePercent,
  });

  factory Output.fromJson(Map<String, dynamic> json) => Output(
        avgDrawdownDuration: json["avg_drawdown_duration"],
        avgDrawdownPercent: json["avg_drawdown_percent"]?.toDouble(),
        avgTradeDuration: json["avg_trade_duration"],
        avgTradePercent: json["avg_trade_percent"]?.toDouble(),
        bestTradePercent: json["best_trade_percent"]?.toDouble(),
        buyAndHoldReturnPercent:
            json["buy_and_hold_return_percent"]?.toDouble(),
        calmarRatio: json["calmar_ratio"]?.toDouble(),
        duration: json["duration"],
        endDay: json["end_day"],
        equityFinal: json["equity_final"]?.toDouble(),
        equityPeak: json["equity_peak"]?.toDouble(),
        exposureTimePercent: json["exposure_time_percent"]?.toDouble(),
        maLength1: json["ma_length1"],
        maLength2: json["ma_length2"],
        maxDrawdownDuration: json["max_drawdown_duration"],
        maxDrawdownPercent: json["max_drawdown_percent"]?.toDouble(),
        maxTradeDuration: json["max_trade_duration"],
        nameIndicator: json["name_indicator"],
        profitFactor: json["profit_factor"]?.toDouble(),
        returnAnnualizedPercent: json["return_annualized_percent"]?.toDouble(),
        returnPercent: json["return_percent"]?.toDouble(),
        sharpeRatio: json["sharpe_ratio"]?.toDouble(),
        sortinoRatio: json["sortino_ratio"]?.toDouble(),
        startDay: json["start_day"],
        tradesCount: json["trades_count"],
        tradingPair: json["trading_pair"],
        volatilityAnnualizedPercent:
            json["volatility_annualized_percent"]?.toDouble(),
        winRatePercent: json["win_rate_percent"]?.toDouble(),
        worstTradePercent: json["worst_trade_percent"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "avg_drawdown_duration": avgDrawdownDuration,
        "avg_drawdown_percent": avgDrawdownPercent,
        "avg_trade_duration": avgTradeDuration,
        "avg_trade_percent": avgTradePercent,
        "best_trade_percent": bestTradePercent,
        "buy_and_hold_return_percent": buyAndHoldReturnPercent,
        "calmar_ratio": calmarRatio,
        "duration": duration,
        "end_day": endDay,
        "equity_final": equityFinal,
        "equity_peak": equityPeak,
        "exposure_time_percent": exposureTimePercent,
        "ma_length1": maLength1,
        "ma_length2": maLength2,
        "max_drawdown_duration": maxDrawdownDuration,
        "max_drawdown_percent": maxDrawdownPercent,
        "max_trade_duration": maxTradeDuration,
        "name_indicator": nameIndicator,
        "profit_factor": profitFactor,
        "return_annualized_percent": returnAnnualizedPercent,
        "return_percent": returnPercent,
        "sharpe_ratio": sharpeRatio,
        "sortino_ratio": sortinoRatio,
        "start_day": startDay,
        "trades_count": tradesCount,
        "trading_pair": tradingPair,
        "volatility_annualized_percent": volatilityAnnualizedPercent,
        "win_rate_percent": winRatePercent,
        "worst_trade_percent": worstTradePercent,
      };
}
