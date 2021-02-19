import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";


  PressedButton(String buttonText) {

    if (buttonText == "Clear") {
       _output = "0";
       num1 = 0.0;
       num2 = 0.0;
       operand = "";
    }
    else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/"){
        num1 = double.parse(output);
        operand = buttonText;
        _output = "0";
    }
    else if (buttonText == ".") {
      if (_output.contains(".")){
        print("Already contains a decimal ");
      }
      else{
        _output = _output + buttonText;
      }
    }
    else if (buttonText == "Ans"){
      num2 = double.parse(output);
      if (operand == "+"){
        _output = (num1 + num2).toString();
      }
      if (operand == "-"){
        _output = (num1 - num2).toString();
      }
      if (operand == "*"){
        _output = (num1 * num2).toString();
      }
      if (operand == "/"){
        _output = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    }
    else {
      _output = _output + buttonText;
    }
    print(_output);
    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buttons(String buttontext,Color rang,Color rang1 ) {
    return Expanded(
      child: FlatButton(
        color: rang,
        padding: EdgeInsets.all(28.0),
        child: Text(buttontext,
          style: TextStyle(
            color: rang1,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () =>
          PressedButton(buttontext)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(output,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 24,horizontal: 12),
              ),

              Expanded(
                  child: Divider(color: Colors.blue,)
              ),
              Column(
                  children:[
                    Row(
                        children: [
                          buttons("7",Colors.white70,Colors.black),
                          buttons("8",Colors.white70,Colors.black),
                          buttons("9",Colors.white70,Colors.black),
                          buttons("-",Colors.black12,Colors.blue),
                        ]),
                    Row(children: [
                      buttons("4",Colors.white70,Colors.black),
                      buttons("5",Colors.white70,Colors.black),
                      buttons("6",Colors.white70,Colors.black),
                      buttons("*",Colors.black12,Colors.blue),
                    ]),
                    Row(children: [
                      buttons("1",Colors.white70,Colors.black),
                      buttons("2",Colors.white70,Colors.black),
                      buttons("3",Colors.white70,Colors.black),
                      buttons("/",Colors.black12,Colors.blue),
                    ]),
                    Row(children: [
                      buttons(".",Colors.white70,Colors.black),
                      buttons("0",Colors.white70,Colors.black),
                      buttons("00",Colors.white70,Colors.black),
                      buttons("+",Colors.black12,Colors.blue),
                    ]),
                    Row(children: [
                      buttons("Clear",Colors.black12,Colors.blue),
                      buttons("Ans",Colors.deepOrange,Colors.white),
                    ]),
                  ])
            ],
          ),
        )
    );
  }
}
