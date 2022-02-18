import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  String _textResult = '';
  String _imageUrl = '';
  TextEditingController _controllerWeight = TextEditingController();
  TextEditingController _controllerHeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calculator'),
      ),
      body: Column(
        children: <Widget>[
          createTextField('Weight: (kg)', _controllerWeight),
          createTextField('Height: (cm)', _controllerHeight),
          Text(_textResult),
          Container(
            height: 50,
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                double weight = double.tryParse(_controllerWeight.text)!;
                double height = double.tryParse(_controllerHeight.text)!;

                if (weight != null && height != null) {
                  height = height / 100;
                  double _imc = (weight / (height * height));

                  setState(() {
                    if (_imc < 18.5) {
                      _textResult = 'IMC: ${_imc.toStringAsPrecision(4)}\nUnder Weight';
                      _imageUrl = 'images/underWeight.png';
                    } else if (_imc >= 18.5 && _imc < 25) {
                      _textResult = 'IMC: ${_imc.toStringAsPrecision(4)}\nNormal Weight';
                      _imageUrl = 'images/normalWeight.png';
                    } else if (_imc >= 25 && _imc < 30) {
                      _textResult = 'IMC: ${_imc.toStringAsPrecision(4)}\nOverweight';
                      _imageUrl = 'images/overWeight.png';
                    } else if (_imc >= 30 && _imc < 35) {
                      _textResult = 'IMC: ${_imc.toStringAsPrecision(4)}\nObesity 1st grade';
                      _imageUrl = 'images/obesity_1.png';
                    } else if (_imc >= 35 && _imc < 40) {
                      _textResult = 'IMC: ${_imc.toStringAsPrecision(4)}\nObesity 2st grade';
                      _imageUrl = 'images/obesity_2.png';
                    } else if (_imc >= 40) {
                      _textResult = 'IMC: ${_imc.toStringAsPrecision(4)}\nObesity 3st grade';
                      _imageUrl = 'images/obesity_3.png';
                    }
                  });
                } else {
                  setState(() {
                    _textResult = 'Invalid Input!';
                  });
                }
              },
              child: Text('Calculate'),
            ),
          ),
          Container(
            child: _imageUrl != '' ? Image(image: AssetImage(_imageUrl)) : null,
          )
        ],
      ),
    );
  }

  createTextField(String inputText, TextEditingController inputController) {
    return TextField(
      controller: inputController,
      keyboardType: TextInputType.number,
    );
  }
}
