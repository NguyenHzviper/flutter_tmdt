// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:price_alert/services/flask_service.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:price_alert/api/firebase_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final FlaskProvider flaskProvider = FlaskProvider();
  final firebaseMessage = FirebaseMessage();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  late Future<List<String>> _tradingPairsFuture;
  late Future<String> _fcmToken;
  late AutoCompleteTextField<String> cusTextField;
  TextEditingController textEditingController = TextEditingController();
  late String selectedTradingPair;
  late double targetPrice;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tradingPairsFuture = _loadTradingPairs();
    _fcmToken = _loadStoredToken();
  }

  Future<List<String>> _loadTradingPairs() async {
    try {
      final pairs = await flaskProvider.getTradingPairs();
      return pairs;
    } catch (e) {
      print('Error loading trading pairs: $e');
      return [];
    }
  }

  Future<String> _loadStoredToken() async {
    try {
      final token = await firebaseMessage.getStoredToken();
      return token ?? '';
    } catch (e) {
      print('Error loading token: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<String>>(
          future: _tradingPairsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while fetching data
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Handle errors when fetching data
              return Center(
                child: Text('Error loading trading pairs: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Handle cases when no data is available
              return Center(child: Text('No trading pairs available.'));
            } else {
              // Data has been successfully loaded, create cusTextField
              final _tradingPairs = snapshot.data!;
              cusTextField = AutoCompleteTextField<String>(
                key: GlobalKey(),
                clearOnSubmit: false,
                suggestions: _tradingPairs,
                controller: textEditingController,
                decoration: InputDecoration(
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
              );

              return Container(
                margin: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      cusTextField,
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Trigger Price',
                          hintText: 'Price',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            targetPrice = double.tryParse(value) ?? 0.0;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a trigger price';
                          }
                          double? parsedValue = double.tryParse(value);
                          if (parsedValue == null || parsedValue <= 0.0) {
                            return 'Invalid price';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await flaskProvider.addAlert(
                              userId,
                              selectedTradingPair,
                              targetPrice.toString(),
                            );
                          }
                        },
                        child: Text("Add alert"),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
