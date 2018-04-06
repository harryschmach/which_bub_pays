import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return new MaterialApp(
      title: 'Which Bub Pays',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
//      home: new MyHomePage(title: 'You or me bubub?'),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Whose turn is it?'),
        ),
        body: new ListView(
          children: [
            new Image.asset(
              'images/sarry.jpg',
              fit: BoxFit.fill,
            ),
            new DinnerRow(),
            new DessertRow(),
          ],
        ),
      ),
    );
  }
}

class DinnerRow extends StatefulWidget{
  @override
  _DinnerRowState createState() => new _DinnerRowState();
}

class _DinnerRowState extends State<DinnerRow>{
  var thisDinnerBuyer;
  var nextDinnerBuyer;
  var lastDinnerDate;
  var isHarry = 0;

  List<String> dabubs= ["Sarah Bub", "Harry Bub"];

  @override
  void initState() {
    super.initState();
    _readDinnerBuyer().then((int value) {
      setState(() {
        isHarry = value;
        thisDinnerBuyer = dabubs[isHarry];

        if (isHarry > 0){
          nextDinnerBuyer = dabubs[0];
        }else{
          nextDinnerBuyer = dabubs[1];
        }

      });
    });
    _readDinnerDate().then((String value) {
      setState(() {
        lastDinnerDate = value;
      });
    });
  }

  Future<File> _getDinnerBubFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/dinner_bub.txt');
  }

  Future<int> _readDinnerBuyer() async {
    try {
      File file = await _getDinnerBubFile();
      // read the variable as a string from the file.
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }
  Future<File> _getDinnerDateFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/dinner_date.txt');
  }

  Future<String> _readDinnerDate() async {
    try {
      File file = await _getDinnerDateFile();
      // read the variable as a string from the file.
      String contents = await file.readAsString();
      return contents;
    } on FileSystemException {
      return 'No date found';
    }
  }


  @override
  Widget build(BuildContext context) {

    return new
      Column(
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              new Container(
                padding: new EdgeInsets.all(4.0),
                child: new IconButton(
                  icon: new Icon(Icons.local_dining),
                  onPressed: _switchDinner,
                ),
              ),
              new Text(
                'Dinner',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),

          new Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Text(
              '$thisDinnerBuyer is buying dinner since $nextDinnerBuyer paid on \n$lastDinnerDate',
              softWrap: true,
            ),
          ),

        ],
      );
  }

  Future<Null> _switchDinner() async {
    setState(() {
      lastDinnerDate = _getTodayString();
      nextDinnerBuyer = dabubs[isHarry];
      if (isHarry > 0){
        isHarry = 0;
      }else{
        isHarry = 1;
      }
      thisDinnerBuyer = dabubs[isHarry];
    });
    await (await _getDinnerBubFile()).writeAsString('$isHarry');
    await (await _getDinnerDateFile()).writeAsString('$lastDinnerDate');
  }

  String _getTodayString(){
    var _now = new DateTime.now();
    var _thisDay = _now.day;
    var _thisMonth = _now.month;
    var _thisYear = _now.year;

    return new DateTime(_thisYear, _thisMonth, _thisDay).toString().substring(0, 10);
  }
}

class DessertRow extends StatefulWidget{
  @override
  _DessertRowState createState() => new _DessertRowState();

}

class _DessertRowState extends State<DessertRow>{
    var thisDesertBuyer;
    var nextDesertBuyer;
    var lastDesertDate;
    var isHarry;

    List<String> dabubs= ["Sarah Bub", "Harry Bub"];

    @override
    void initState() {
      super.initState();
      _readDessertBuyer().then((int value) {
        setState(() {
          isHarry = value;
          thisDesertBuyer = dabubs[isHarry];

          if (isHarry > 0){
            nextDesertBuyer = dabubs[0];
          }else{
            nextDesertBuyer = dabubs[1];
          }

        });
      });
      _readDessertDate().then((String value) {
        setState(() {
          lastDesertDate = value;
        });
      });
    }

    Future<File> _getDessertBubFile() async {
      // get the path to the document directory.
      String dir = (await getApplicationDocumentsDirectory()).path;
      return new File('$dir/dessert_bub.txt');
    }

    Future<int> _readDessertBuyer() async {
      try {
        File file = await _getDessertBubFile();
        // read the variable as a string from the file.
        String contents = await file.readAsString();
        return int.parse(contents);
      } on FileSystemException {
        return 0;
      }
    }
    Future<File> _getDessertDateFile() async {
      // get the path to the document directory.
      String dir = (await getApplicationDocumentsDirectory()).path;
      return new File('$dir/dessert_date.txt');
    }

    Future<String> _readDessertDate() async {
      try {
        File file = await _getDessertDateFile();
        // read the variable as a string from the file.
        String contents = await file.readAsString();
        return contents;
      } on FileSystemException {
        return 'No date found';
      }
    }


    @override
    Widget build(BuildContext context) {

      return new
      Column(
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                padding: new EdgeInsets.all(4.0),
                child: new IconButton(
                  icon: new Icon(Icons.cake),
                  onPressed: _switchDessert,
                ),
              ),
              new Text(
                'Dessert',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
          new Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Text(
              '$thisDesertBuyer is buying dinner since $nextDesertBuyer paid on \n$lastDesertDate',
              softWrap: true,
            ),
          ),
        ],
      );
    }

    Future<Null> _switchDessert() async {
      setState(() {
        lastDesertDate = _getTodayString();
        nextDesertBuyer = dabubs[isHarry];
        if (isHarry > 0){
          isHarry = 0;
        }else{
          isHarry = 1;
        }
        thisDesertBuyer = dabubs[isHarry];
      });
      await (await _getDessertBubFile()).writeAsString('$isHarry');
      await (await _getDessertDateFile()).writeAsString('$lastDesertDate');
    }

    String _getTodayString(){
      var _now = new DateTime.now();
      var _thisDay = _now.day;
      var _thisMonth = _now.month;
      var _thisYear = _now.year;

      return new DateTime(_thisYear, _thisMonth, _thisDay).toString().substring(0, 10);
    }
}
