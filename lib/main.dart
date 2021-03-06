import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:ui';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Basic Calculator",
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: BasicCalculator(),
    );
  }
}

class BasicCalculator extends StatefulWidget {
  @override
  _BasicCalculatorState createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {

  String equation = "0";
  String result = "";
  String expression = "";
  double equationFont = 38.0;
  double resultFont = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "";
        equationFont = 38.0;
        resultFont = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFont = 48.0;
        resultFont = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFont = 38.0;
        resultFont = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFont = 48.0;
        resultFont = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,Color rang){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: rang
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
        centerTitle: true,
        toolbarHeight: 0,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFont)),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFont),),
          ),


          Expanded(
            child: Divider(color: Colors.grey,),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Colors.grey[400],Colors.deepOrange),
                          buildButton("⌫", 1, Colors.grey[400],Colors.deepOrange),
                          buildButton("÷", 1, Colors.grey[400],Colors.deepOrange),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.white,Colors.black),
                          buildButton("8", 1, Colors.white,Colors.black),
                          buildButton("9", 1, Colors.white,Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.white,Colors.black),
                          buildButton("5", 1, Colors.white,Colors.black),
                          buildButton("6", 1, Colors.white,Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.white,Colors.black),
                          buildButton("2", 1, Colors.white,Colors.black),
                          buildButton("3", 1, Colors.white,Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("0", 1, Colors.white,Colors.black),
                          buildButton(".", 1, Colors.white,Colors.black),
                          buildButton("00", 1, Colors.white,Colors.black),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.grey[400],Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.grey[400],Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.grey[400],Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.deepOrange,Colors.black),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}