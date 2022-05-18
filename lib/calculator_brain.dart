import 'dart:math';

class CalculatorBrain{

  CalculatorBrain({this.height = 0, this.weight = 0});

  final int height;
  final int weight;
  double _bmi = 0;

  String calculateBMI() {
    _bmi = weight/ pow(height/100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult(){
    if(_bmi >= 25){
      return 'Overweight';
    }
    else if (_bmi > 18.5){
      return 'Normal';
    }
    else {
      return 'Underweight';
    }
  }
}