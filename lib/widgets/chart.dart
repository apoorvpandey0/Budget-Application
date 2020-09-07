import 'package:budget_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  // This will store the last seven days transactions
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  // This List contains total amount spent on each day as a map
  List<Map<String, Object>> get groupedTransactionValues {
    // Using generate method and since we need seven bars for seven days hence 7
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      // Calculating total amount of that day
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // returning the map to get into the list
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    // This calculates the total spending in the week
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final isLandscape =
    // MediaQuery.of(context).orientation == Orientation.landscape;

    // This is the main card that contains everything
    return Card(
      child: Container(
        // This is the main row that will contain 7 column/bars
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((tx) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tx['day'],
                  amount: tx['amount'],
                  spendingPct: totalSpending == 0.0
                      ? 0.0
                      : (tx['amount'] as double) / totalSpending,
                ),
              );
            }).toList()),
        width: double.infinity,
        padding: EdgeInsets.all(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(20),
    );
  }
}
