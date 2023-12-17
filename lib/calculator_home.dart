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
  /*Todo Actividad2: Se añade el SingleChildScrollView para que tenga desplazamiento
  * también se pone los Flexible para que no se desestructure y se fije su posición */
  //Todo Actividad3: Se pone el fondo de color negro
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(flex: 2, fit: FlexFit.tight, child: _equationPanel()),
          Flexible(flex: 2, fit: FlexFit.tight, child: _resultPanel()),
          Expanded(flex: 5, child: SingleChildScrollView(
            child: _buttonPanel(),
          ))
        ],
      ),
    );
  }
  //Todo Actividad3: Se pone el fondo de color negro
  Widget _equationPanel(){
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.black,
      padding: EdgeInsets.all(10),
      child: Text(
        _equationText,
        style: TextStyle(fontSize: _equationFontSize,color: Colors.white),
      ),
    );
  }
  /*Todo Actividad1: Se fija el ancho del contenedor con la propiedad height para que no se modifique su tamaño y se añade un FittedBox
  *para que se vaya ajustando a la cantidad de números y siempre se muestre en número completo */
  //Todo Actividad3: Se pone el fondo de color negro
  Widget _resultPanel(){
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.all(1.0),
      color: Colors.black,
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
  //Todo Actividad3: Se redondean los bordes del botón
  Widget _calcButton(String text, Color color){
    return Container(
      margin: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(50)),
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        onPressed: () => _onCalcButtonPressed(text),
      ),
    );
  }
  //Todo Actividad3: Se le cambian los colores a los botones y al container
  Widget _buttonPanel(){
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('C', Colors.grey.shade400),),
              Expanded(child:_calcButton('DEL', Colors.grey.shade400),),
              Expanded(child:_calcButton('%', Colors.grey.shade400),),
              Expanded(child:_calcButton('÷', Colors.orange),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('7', Colors.grey.shade700),),
              Expanded(child:_calcButton('8', Colors.grey.shade700),),
              Expanded(child:_calcButton('9', Colors.grey.shade700),),
              Expanded(child:_calcButton('×', Colors.orange),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('4', Colors.grey.shade700),),
              Expanded(child:_calcButton('5', Colors.grey.shade700),),
              Expanded(child:_calcButton('6', Colors.grey.shade700),),
              Expanded(child:_calcButton('-', Colors.orange),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('1', Colors.grey.shade700),),
              Expanded(child:_calcButton('2', Colors.grey.shade700),),
              Expanded(child:_calcButton('3', Colors.grey.shade700),),
              Expanded(child:_calcButton('+', Colors.orange),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child:_calcButton('0', Colors.grey.shade700),),
              Expanded(child:_calcButton('.', Colors.grey.shade700),),
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
