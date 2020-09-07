// This package is required for @required
// We can also use material.dart, it also extends to foundation.dart
import 'package:flutter/foundation.dart';

// This class is simply a blueprint for Transation details and not a Widget(since we dont want to render it on screen)
class Transaction {
  int id;
  String title;
  double amount;
  DateTime date;

  Transaction({@required this.id, this.title, this.amount, this.date});
}
