import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorHome extends StatefulWidget {
  static const double fontSizeMedium = 38.0;
  static const double fontSizeBig = 48.0;
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _equationText = '0';
  String _resultText = '0';
  double _equationFontSize = CalculatorHome.fontSizeMedium;
  double _resultFontSize = CalculatorHome.fontSizeBig;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _equationPanel(),
            _resultPanel(),
            _buttonPanel(),
          ],
        ),
      ),
    );
  }
  Widget _equationPanel(){
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(10),
      child: Text(
        _equationText,
        style: TextStyle(fontSize: _equationFontSize),
      ),
    );
  }
  /*Todo Actividad1: Se fija el ancho del contenedor con la propiedad height para que no se modifique su tamaño y se añade un FittedBox
  para que se vaya ajustando a la cantidad de números y siempre se muestre en número completo */
  Widget _resultPanel(){
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(
          color: Colors.blue.shade200,
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(10),
      height: 80,
      child: FittedBox(
        child: Text(
          _resultText,
          style: TextStyle(
            fontSize: _resultFontSize,
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }
  Widget _calcButton(String text, Color color){
    return Container(
      margin: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: color,),
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        onPressed: () => _onCalcButtonPressed(text),
      ),
    );
  }
  Widget _buttonPanel(){
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('C', Colors.orange),),
              Expanded(child:_calcButton('DEL', Colors.redAccent),),
              Expanded(child:_calcButton('%', Colors.lightBlue),),
              Expanded(child:_calcButton('÷', Colors.lightBlue),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('7', Colors.grey.shade400),),
              Expanded(child:_calcButton('8', Colors.grey.shade400),),
              Expanded(child:_calcButton('9', Colors.grey.shade400),),
              Expanded(child:_calcButton('×', Colors.lightBlue),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('4', Colors.grey.shade400),),
              Expanded(child:_calcButton('5', Colors.grey.shade400),),
              Expanded(child:_calcButton('6', Colors.grey.shade400),),
              Expanded(child:_calcButton('-', Colors.lightBlue),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('1', Colors.grey.shade400),),
              Expanded(child:_calcButton('2', Colors.grey.shade400),),
              Expanded(child:_calcButton('3', Colors.grey.shade400),),
              Expanded(child:_calcButton('+', Colors.lightBlue),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('0', Colors.grey.shade400),),
              Expanded(child:_calcButton('.', Colors.grey.shade400),),
              Expanded(child:_calcButton('=', Colors.orange), flex: 2,),
            ],
          ),
        ],
      ),
    );
  }
  String _evaluateEquation(){
    Parser parser = Parser();
    String expresion = _equationText;
    String operationResult = '';
    expresion = expresion.replaceAll('×', '*');
    expresion = expresion.replaceAll('÷', '/');
    try{
      Expression exp = parser.parse(expresion);
      operationResult = '${exp.evaluate(EvaluationType.REAL, ContextModel())}';
    }catch(e){
      operationResult='Error in expression';
    }
    return operationResult;
  }
  void _onCalcButtonPressed(String text){
    setState(() {
      if(text == 'C'){
        _equationText='0';
        _resultText='0';
        _equationFontSize=CalculatorHome.fontSizeMedium;
        _resultFontSize=CalculatorHome.fontSizeBig;
      }else if(text=='DEL'){
        _equationText = _equationText.substring(0,_equationText.length-1);
        if(_equationText.isEmpty){
          _equationText='0';
        }
        _equationFontSize=CalculatorHome.fontSizeBig;
        _resultFontSize=CalculatorHome.fontSizeMedium;
      }else if(text=='='){
        _equationFontSize=CalculatorHome.fontSizeMedium;
        _resultFontSize=CalculatorHome.fontSizeBig;
        _resultText=_evaluateEquation();
      }else{
        if(_equationText=='0'){
          _equationText=text;
        }else{
          _equationText+=text;
        }
      }
    });
  }
}
