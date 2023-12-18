import 'package:price_alert/models/backtest_model.dart';
import 'package:price_alert/screens/backtest_result_screen.dart';
import 'package:price_alert/services/flask_service.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class BackTestScreen extends StatefulWidget {
  const BackTestScreen({super.key});

  @override
  State<BackTestScreen> createState() => _BackTestScreenState();
}

class _BackTestScreenState extends State<BackTestScreen> {
  final FlaskProvider flaskProvider = FlaskProvider();
  late AutoCompleteTextField<String> cusTextField;
  TextEditingController textEditingController = TextEditingController();
  late String selectedTradingPair;
  late bool isProcessing;
  late int maLength1;
  late int maLength2;
  late Backtest backtestdata;
  final _formKey = GlobalKey<FormState>();

  final List<String> _suggestions = [
    "BTC-USD",
    "ETH-USD",
    "XRP-USD",
  ];

  @override
  void initState() {
    super.initState();
    isProcessing = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              AutoCompleteTextField<String>(
                key: GlobalKey(),
                clearOnSubmit: false,
                suggestions: _suggestions,
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Select Trading Pair',
                  hintText: 'Enter a trading pair',
                  prefixIcon: Icon(Icons.search),
                ),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion),
                ),
                itemSorter: (a, b) => a.compareTo(b),
                itemFilter: (suggestion, input) =>
                    suggestion.toLowerCase().contains(input.toLowerCase()),
                itemSubmitted: (suggestion) {
                  setState(() {
                    selectedTradingPair = suggestion;
                    textEditingController.text = suggestion;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MA long term',
                  hintText: 'MA length',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    maLength1 = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ma length';
                  }
                  int? parsedValue = int.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Invalid ma length';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MA short term',
                  hintText: 'MA length',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    maLength2 = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ma length';
                  }
                  int? parsedValue = int.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Invalid ma length';
                  } else if (parsedValue > maLength1) {
                    return 'MA short term must be less than MA long term';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      Backtest result = await flaskProvider.handleBackTest(
                        selectedTradingPair,
                        maLength1,
                        maLength2,
                        (bool progress) {
                          setState(() {
                            isProcessing = progress;
                          });
                        },
                      );
                      setState(() {
                        backtestdata = result;
                      });
                    } finally {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BacktestResultScreen(
                                  result: backtestdata,
                                )),
                      );
                    }
                  }
                },
                child: isProcessing
                    ? const CircularProgressIndicator()
                    : const Text("Backtest"),
              ),
            ],
          )),
    ));
  }
}
