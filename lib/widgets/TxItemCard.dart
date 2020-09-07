import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

class TxItemCard extends StatelessWidget {
  const TxItemCard({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // For padding the entire card
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 3,
        child: ListTile(
          // onTap: () {},

          // For the transaction Amount
          leading: CircleAvatar(
            child: FittedBox(
                child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(transaction.amount.toString()),
            )),
          ),

          // For transaction title
          title: Text(transaction.title),

          // Transaction Date
          subtitle: Text(DateFormat.yMMMMd().format(transaction.date)),

          //Delete transaction
          trailing: IconButton(

              // We can add const to the icon part since it is always constant
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),

              // We need to use anoynomous Fn here otherwise the delete fulction would be called instantly
              // Or inOtherWords we need to pass the pointer to the fn
              onPressed: () => deleteTransaction(transaction.id)),
        ),
      ),
    );
  }
}
