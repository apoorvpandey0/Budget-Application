import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // To disable landscape mode

import './widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/myDrawer.dart';
import 'widgets/chart.dart';

void main() {
  // The two statements below Set the orientation to portrait only
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // This starts the main application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Home Page',
      home: HomePage(),
      // We can define our theme data here
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light()
                  .textTheme
                  .copyWith(headline6: TextStyle(fontFamily: 'OpenSans'))),

          // This defines the primary colorSwatch for the entire application
          primarySwatch: Colors.purple,
          fontFamily: 'QuickSand'),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  int iD = 1;
  bool _switchValue = false;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime choosenDate) {
    // print(title);
    // print(amount);
    // print(choosenDate.toString());
    final newTx =
        Transaction(id: ++iD, amount: amount, title: title, date: choosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
    // print(_userTransactions);
  }

  void _deleteTransaction(int id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _openModalFunction(ctx) {
    // print('Modal Openedddddddddddddddd');
    showModalBottomSheet(
        enableDrag: true,
        context: ctx,
        builder: (_) {
          // print('Inside builderrrrrrrrrrrrrrrrrrrrr');
          return NewTransaction(_addTransaction);
        });
  }

  // App Life Cycle detection
  @override
  void initState() {
    // Adding the event listener
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifeCycle(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    // Removing the event listener
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The lines below contain variable declarations

    // We need check for landscape each time we call our build method
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Using variables to store widgets give helps us reduce redundant code writing
    final appBar = AppBar(
      // Title of the AppBar
      title: Text("Budget App",
          style: TextStyle(
            fontSize: 22,
          )),

      // Extra widgets on the appbar
      actions: <Widget>[
        // Icon button is just another type of button

        // Search button
        IconButton(icon: Icon(Icons.search), onPressed: () {}),

        // Add button
        IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () => _openModalFunction(context),
        ),
      ],
    );

    // This variable holds the txList
    final txList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    List<Widget> _buildLandscapeContent() {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Show Chart"),

            // adaptive means the button will change according to the platform the app is on
            Switch.adaptive(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                }),
          ],
        ),
        _switchValue
            ?
            // This is the graph card in Landscape mode
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: Chart(_recentTransactions))
            : txList
      ];
    }

    List<Widget> _buildPortraitContent() {
      return [
        Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            child: Chart(_recentTransactions)),
        txList
      ];
    }

    // This is the build method of the State class
    return Scaffold(
      // App Bar Configuration
      appBar: appBar,

      // Drawer configuration
      drawer: MyDrawer(),

      // Body of Scaffold Configuration
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // This is a special IF and is read as:
            // IF True then render the Row o ELSE nothing
            if (isLandscape)
              // If portrait then render both Chart and List
              ..._buildLandscapeContent(),
            if (!isLandscape)
              ..._buildPortraitContent(),

            // NewTransaction(_addTransaction),
          ],
        ),
      ),

      // This helps position the floating action buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // This is the button at the bottom
      floatingActionButton:
          Platform.isIOS // Platform.isIOS is from dart:io package
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                      elevation: 5,
                      child: Icon(Icons.add_box),
                      onPressed: () => _openModalFunction(context)),
                ),
    );
  }
}
