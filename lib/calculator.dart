import 'package:flutter/material.dart';
import 'widgets/number_button.dart';
import 'widgets/unary_operator_button.dart';
import 'widgets/binary_operator_button.dart';

const equal_sign = "\u003D";
const add_sign = "\u002B";
const minus_sign = "-";
const multiply_sign = "\u00D7";
const divide_sign = "\u00F7";
const plus_or_minus_sign = "+/-";
const percent_sign = "%";
const clear_sign = "AC";

// enum Operation{ none, divide, multiply, subtract, add, clear, changeSign, addDecimal, percent, equals, }
enum UnaryOperation { changeSign, percent, del,}
enum BinaryOperation { divide, multiply, subtract, add, }
enum OtherOperation { clear, addDecimal, equals, }

class CalculatorApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Calculator",
      theme: ThemeData.dark(),
      home: new HomePage(title: "Flutter Calculator HomePage"),
    );
  }
}

class HomePage extends StatefulWidget{
  HomePage({Key key,this.title}) : super(key:key);
  final String title;
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var op1,op2,result;
  String operator;
  bool isOp1Completed;
  TextStyle _whiteTextStyle = TextStyle(color: Colors.white, fontSize: 35.0,);

  @override
  void initState(){
    super.initState();
    initialiseValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          op1 != null ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              op1 is double ? op1.toStringAsFixed(4) : op1.toString(),
                              style: _whiteTextStyle,
                              textAlign: TextAlign.right,
                            )
                          )
                              :Container(),

                          operator != null ? Text(
                            operator.toString(),
                            style: _whiteTextStyle,
                            textAlign: TextAlign.right,
                          )
                              :Container(),

                          op2 != null ? Text(
                            op2.toString(),
                            style: _whiteTextStyle,
                            textAlign: TextAlign.right,
                          )
                              :Container(),

                          result != null ? Divider(
                            height: 5.0,
                            color: Colors.white,
                          )
                              :Container(),

                          result != null ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                result is double ? result.toStringAsFixed(4) : result.toString(),
                                style: _whiteTextStyle,
                                textAlign: TextAlign.right,
                              )
                          )
                              :Container(),

                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    UnaryOperatorButton(
                      text: "AC",
                      onPressed: (){_otherOperationAction(OtherOperation.clear);},
                    ),

                    UnaryOperatorButton(
                      text: plus_or_minus_sign,
                      onPressed: (){_unaryOperationAction(UnaryOperation.changeSign);},
                    ),

                    UnaryOperatorButton(
                      text: percent_sign,
                      onPressed: (){_unaryOperationAction(UnaryOperation.percent);},
                    ),

                    BinaryOperatorButton(
                      text: divide_sign,
                      onPressed: (){_binaryOperationAction(BinaryOperation.divide);},
                    )

                  ],
                 ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    NumberButton(
                      text: "7",
                      onPressed: (){_numberButtonAction("7");}
                    ),

                    NumberButton(
                        text: "8",
                        onPressed: (){_numberButtonAction("8");}
                    ),

                    NumberButton(
                        text: "9",
                        onPressed: (){_numberButtonAction("9");}
                    ),

                    BinaryOperatorButton(
                      text: multiply_sign,
                      onPressed: (){_binaryOperationAction(BinaryOperation.multiply);},
                    )

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    NumberButton(
                        text: "4",
                        onPressed: (){_numberButtonAction("4");}
                    ),

                    NumberButton(
                        text: "5",
                        onPressed: (){_numberButtonAction("5");}
                    ),

                    NumberButton(
                        text: "6",
                        onPressed: (){_numberButtonAction("6");}
                    ),

                    BinaryOperatorButton(
                      text: minus_sign,
                      onPressed: (){_binaryOperationAction(BinaryOperation.subtract);},
                    )

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    NumberButton(
                        text: "1",
                        onPressed: (){_numberButtonAction("1");}
                    ),

                    NumberButton(
                        text: "2",
                        onPressed: (){_numberButtonAction("2");}
                    ),

                    NumberButton(
                        text: "3",
                        onPressed: (){_numberButtonAction("3");}
                    ),

                    BinaryOperatorButton(
                      text: add_sign,
                      onPressed: (){_binaryOperationAction(BinaryOperation.add);},
                    )

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    //ZeroButton(onPressed: (){_zeroButtonAction();},),
                    NumberButton(
                        text: "0",
                        onPressed: (){_numberButtonAction("0");}
                    ),

                    UnaryOperatorButton(
                      text: "DEL",
                      onPressed: (){_unaryOperationAction(UnaryOperation.del);},
                    ),

                    BinaryOperatorButton(
                      text: ".",
                      onPressed: (){_otherOperationAction(OtherOperation.addDecimal);},
                    ),

                    BinaryOperatorButton(
                      text: equal_sign,
                      onPressed: (){_otherOperationAction(OtherOperation.equals);},
                    ),

                  ],
                )
              ],
            ),
          )
      )
    );
  }

  void initialiseValues(){
    op1 = null;
    op2 = null;
    result = null;
    operator = null;
    isOp1Completed = false;
  }

  void _findOutput(){
    if(op1 == null || op2 == null)
      return;
    var exp1 = double.parse(op1.toString());
    var exp2 = double.parse(op2.toString());
    switch(operator){
      case add_sign:  result = exp1 + exp2;
                      result = result.toString();
                      break;
      case minus_sign:  result = exp1 - exp2;
                        result = result.toString();
                        break;
      case multiply_sign: result = exp1 * exp2;
                          result = result.toString();
                          break;
      case divide_sign: result = exp1 / exp2;
                        result = result.toString();
                        break;
      case percent_sign:  result = exp1 % exp2;
                          result = result.toString();
                          break;
    }
    if(result.toString().endsWith(".0")){
      result = (result.toString().replaceAll(".0",""));
    }
  }

  void _numberButtonAction(String text) {
    if (result != null) initialiseValues();
    if (isOp1Completed) {
      if (op2 == null) {
        op2 = text;
      }
      else {
        if (op2.toString().length < 15) op2 += text;
        }
      }
        else {
           if (op1 == null) {
            op1 = text;
      } else {
        if (op1.toString().length < 15) op1 += text;
      }
    }
    setState(() {});
  }

  void _binaryOperationAction(BinaryOperation operation) {
    switch (operation) {

        case BinaryOperation.add:
        if (op2 != null) {
          if (result == null) _findOutput();
          op1 = result;
          op2 = null;
          result = null;
        }
        operator = add_sign;
        isOp1Completed = true;
        break;

        case BinaryOperation.subtract:
        if (op2 != null) {
          if (result == null) _findOutput();
          op1 = result;
          op2 = null;
          result = null;
        }
        operator = minus_sign;
        isOp1Completed = true;
        break;

        case BinaryOperation.multiply:
        if (op2 != null) {
          if (result == null) _findOutput();
          op1 = result;
          op2 = null;
          result = null;
        }
        operator = multiply_sign;
        isOp1Completed = true;
        break;

        case BinaryOperation.divide:
        if (op2 != null) {
          if (result == null) _findOutput();
          op1 = result;
          op2 = null;
          result = null;
        }
        operator = divide_sign;
        isOp1Completed = true;
        break;
    }
    setState(() {});
  }

  void _unaryOperationAction(UnaryOperation operation) {
    switch (operation) {

      case UnaryOperation.changeSign:
        if (result != null)
          result = -result;
        else if (isOp1Completed) {
          if (op2 != null) {
            op2 = (-int.parse(op2)).toString();
          }
        } else {
          if (op1 != null) {
            op1 = (-int.parse(op1)).toString();
          }
        }
        break;

      case UnaryOperation.percent:
        if (result != null)
          result = result / 100;
        else if (isOp1Completed) {
          if (op2 != null) {
            op2 = (double.parse(op2) / 100).toString();
          }
        } else {
          if (op1 != null) {
            op1 = (double.parse(op1) / 100).toString();
          }
        }
        break;

      case UnaryOperation.del:
        var x;
        if (result != null)
        {
          x = result.length;
          result = result.substring(0,x-1);
        }
        else if (isOp1Completed) {
          if (op2 != null) {
            x = op2.length;
            op2 = op2.substring(0,x-1);
          }
        } else {
          if (op1 != null) {
            x = op1.length;
            op1 = op1.substring(0,x-1);
          }
        }
        break;
    }
    setState(() {});
  }
  _otherOperationAction(OtherOperation operation) {
    switch (operation) {

      case OtherOperation.clear:
        initialiseValues();
        break;

      case OtherOperation.addDecimal:
        if (result != null) initialiseValues();
        if (isOp1Completed) {
          if (!op2.toString().contains(".")) {
            if (op2 == null) {
              op2 = ".";
            } else {
              op2 += ".";
            }
          }
        } else {
          if (!op1.toString().contains(".")) {
            if (op1 == null) {
              op1 = ".";
            } else {
              op1 += ".";
            }
          }
        }
        break;

      case OtherOperation.equals:
        if (result == null) _findOutput();
        break;

    }
    setState(() {});
  }
}