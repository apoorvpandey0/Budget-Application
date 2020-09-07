import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingPct;

  // This constructor can be const since it has only final properties
  const ChartBar({this.label, this.amount, this.spendingPct});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(children: <Widget>[
        // Amount spent on that day
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text('${amount.toStringAsFixed(0)}'))),

        // Spacing
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),

        // Vertical bars
        Container(
          // These are the dimensions of the bar
          height: constraints.maxHeight * 0.60,
          width: 15,

          // We use stack to put widgets over one another... like a stack :)
          child: Stack(
            children: <Widget>[
              // This simply holds the background border in place
              Container(
                decoration: BoxDecoration(

                    // This is the background geyish color
                    color: Color.fromRGBO(220, 220, 220, 1),

                    // This sets the border radius and smoothes it out
                    borderRadius: BorderRadius.circular(100),

                    // This specifies vorder properties
                    border: Border.all(color: Colors.grey, width: 1)),
              ),

              // This is the box that gives the filled look to a bar
              FractionallySizedBox(
                  heightFactor: spendingPct,

                  // To fill the Sized Box up
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ))
            ],
          ),
        ),

        // Spacing
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),

        // Bottom day
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label)))
      ]);
    });
  }
}
