import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/coin.dart';

class CoinTable extends StatelessWidget {
  final List<Coin> data;

  const CoinTable({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: 1,
      sortAscending: false,
      columnSpacing: 20,
      headingRowHeight: 40,
      columns: const [
        DataColumn(
          label: Expanded(
            child: Text(
              "#",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Market Cap",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Price",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      rows: [
        for (int i = 0; i < data.length; i++)
          DataRow(
            cells: [
              DataCell(Text("${i + 1}")),
              DataCell(
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.network(data[i].logo),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[i].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(NumberFormat.compactSimpleCurrency(
                            locale: 'en-US',
                            decimalDigits: 3,
                          ).format(data[i].marketCap))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                Text(
                  NumberFormat.simpleCurrency(
                    locale: 'en-US',
                    decimalDigits: 2,
                  ).format(data[i].currPice),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
