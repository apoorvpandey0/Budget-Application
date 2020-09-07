import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
// import './TxItemCard.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                        'No Transactions available. Maybe try adding some :)'),
                    height: isLandscape
                        ? constraints.maxHeight * .15
                        : constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  // For BoxFit.cover to work we will need an immidiate Parent of Image thats why we are using container
                  Container(
                    height: isLandscape
                        ? constraints.maxHeight * .7
                        : constraints.maxHeight * .5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      // fit: BoxFit.cover,
                    ),
                  )
                ]);
          })
        : ListView.builder(
            // Number of items in the list
            itemCount: transactions.length,

            // returns the widget wrapped transactions list
            itemBuilder: (kontext, index) {
              return TxItemCard(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction);
            },
          );
  }
}

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
