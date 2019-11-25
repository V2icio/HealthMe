import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Meu IMC'),
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
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  int _genderValue = null;

  String imcString = ' ', classificString = ' ', rangeString = ' ', diferencaString = ' ';
  Color colorText = Colors.black;
  geraStrings(double imc, double diferenca)
  {
    if(imc == 0){
      colorText = Colors.black;
      imcString = '-';
      classificString = '-';
      rangeString = '-';
      diferencaString = '-';
      return;
    }


    if(imc < 18.5){
      colorText = Colors.blue;
      diferencaString = '-' + diferenca.toStringAsFixed(0);
    }else if(imc < 25){
      colorText = Colors.green;
      diferencaString = '-';
    }else{
      colorText = Colors.red;
      diferencaString = '+' + diferenca.toStringAsFixed(0);
    }

    imcString = imc.toStringAsFixed(1);

    if(imc < 17){
      classificString = 'Muito abaixo do peso';
      rangeString = '< 17';
    }else if(imc < 18.5){
      classificString = 'Abaixo do peso';
      rangeString = '17 - 18.49';
    }else if(imc < 25){
      classificString = 'Peso normal';
      rangeString = '18.5 - 24.9';
    }else if(imc < 30){
      classificString = 'Acima do peso';
      rangeString = '25 - 29.9';
    }else if(imc < 35){
      classificString = 'Obesidade I';
      rangeString = '30 - 34.9';
    }else if(imc < 40){
      classificString = 'Obesidade II (severa)';
      rangeString = '35 - 39.9';
    }else{
      classificString = 'Obesidade III (mórbida)';
      rangeString = '> 40';
    }
  }

  calculaIMC(){
    if(ageController.text == "" || heightController.text == "" || weightController.text == "" || _genderValue == null){
      geraStrings(0,0);
    }

    double imc, diferenca;
    imc = double.parse(weightController.text)/pow(double.parse(heightController.text)/100, 2);
    if(imc < 18.5){
      diferenca = 18.5 * pow(double.parse(heightController.text)/100, 2) - double.parse(weightController.text);
    }else{
      diferenca = double.parse(weightController.text) - 24.99 * pow(double.parse(heightController.text)/100, 2);
    }

    geraStrings(imc, diferenca);

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            children: <Widget>[
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              labelText:'Idade',
                              //border: InputBorder.none,
                              hintText: 'Sua idade'
                          ),
                          controller: ageController,
                          onChanged: (ageController){
                            calculaIMC();
                          },
                        ),
                      )
                  ),

                  SizedBox(
                    width: 12,
                  ),

                  Container(
                    child: Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText:'Altura',
                            //border: InputBorder.none,
                            hintText: 'Sua altura em cm'
                        ),
                          controller: heightController,
                        onChanged: (heightController){
                          calculaIMC();
                        },
                      ),
                    ),
                  ),

                ],
              ),

              Row(
                children: <Widget>[
                  Container(
                      child: Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              labelText:'Peso',
                              //border: InputBorder.none,
                              hintText: 'Insira seu peso em kg'
                          ),
                          controller: weightController,
                          //onEditingComplete: calculaIMC(),
                          onChanged: (weightController){
                            calculaIMC();
                          },

                        ),
                      )
                  ),

                  SizedBox(width: 12,),

                  Container(
                    width: 74,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _genderValue == 1
                              ? Colors.black
                              : Colors.white,
                          width: 2),
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        if (_genderValue != 1) {
                          setState(() {
                            calculaIMC();
                            _genderValue = 1;
                          });
                        }
                      },
                      child: Text('Homem',style: TextStyle(fontSize: 16),),
                    ),
                  ),

                  SizedBox(width: 8,),


                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _genderValue == 2
                              ? Colors.black
                              : Colors.white,
                          width: 2),
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        if (_genderValue != 2) {
                          setState(() {
                            calculaIMC();
                            _genderValue = 2;
                          });
                        }
                      },
                      child: Text('Mulher',style: TextStyle(fontSize: 16),),
                    ),
                  ),

                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 12,),
                        Text('Seu IMC é de: ', style: TextStyle(fontSize: 24),),
                        SizedBox(height: 12,),
                        Text(imcString, style: TextStyle(fontSize: 40, color: colorText, ),),
                        Text(classificString, style: TextStyle(fontSize: 24, color: colorText, ),),
                        Text(rangeString, style: TextStyle(fontSize: 18, color: colorText, ),),
                      ],
                    )
                  ],
                ),
              ),

              Divider(
                height: 20,
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Diferença:',style: TextStyle(fontSize: 24, color: colorText, )),
                    SizedBox(width: 60,),
                    Text(diferencaString,style: TextStyle(fontSize: 24, color: colorText, )),
                  ],
                ),

              ),

              Divider(
                height: 20,
              ),

              Container(
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Resultado',style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,
                            decoration: TextDecoration.underline)
                        ),
                        Text('Abaixo de 17'),
                        Text('Entre 17 e 18,49'),
                        Text('Entre 18,5 e 24,99'),
                        Text('Entre 25 e 29,99'),
                        Text('Entre 30 e 34,99'),
                        Text('Entre 35 e 39,99'),
                        Text('Acima de 40'),


                      ],
                    ),

                    SizedBox(width: 60),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                        Text('Situação',style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,
                            decoration: TextDecoration.underline)
                        ),
                        Text('Muito abaixo do peso'),
                        Text('Abaixo do peso'),
                        Text('Peso normal'),
                        Text('Acima do peso'),
                        Text('Obesidade I'),
                        Text('Obesidade II (severa)'),
                        Text('Obesidade III (mórbida)'),
                      ],
                    )
                  ],
                ),
              )


            ],
          )
        ),
      ),
    );
  }
}
