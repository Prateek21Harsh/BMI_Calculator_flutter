import 'package:bmi_calculator/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'round_icon_button.dart';
import 'results_page.dart';
import 'bottom_button.dart';
import 'calculator_brain.dart';


enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  int height = 180;
  int weight = 60;
  int age = 24;
  Color maleCardColour = kInactiveCardColour;
  Color femaleCardColour = kInactiveCardColour;

  void updateColour(Gender gender){
    if(gender == Gender.male){
      if(maleCardColour == kInactiveCardColour) {
        maleCardColour = kActiveCardColour;
        femaleCardColour = kInactiveCardColour;
      }
      else
        maleCardColour = kInactiveCardColour;
    }

    if(gender == Gender.female){
      if(femaleCardColour == kInactiveCardColour) {
        femaleCardColour = kActiveCardColour;
        maleCardColour = kInactiveCardColour;
      }
      else
        femaleCardColour = kInactiveCardColour;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          children: [
            Expanded(child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                      onPress: (){
                        setState(() {
                          updateColour(Gender.male);
                        });
                      },
                      colour: maleCardColour,
                      cardChild: IconContent(icon: FontAwesomeIcons.mars, label: 'MALE',),
                    )
                ),
                Expanded(
                    child: ReusableCard(
                      onPress: (){
                        setState(() {
                          updateColour(Gender.female);
                        });
                      },
                      colour: femaleCardColour,
                      cardChild: IconContent(icon: FontAwesomeIcons.venus, label: 'FEMALE',),
                    )
                ),
              ],
            )),
            Expanded(child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'HEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                height.toString(),
                                style: kNumberTextStyle,
                              ),
                              Text(
                                'cm',
                                style: kLabelTextStyle,
                              )
                            ],
                          ),
                          Slider(
                            value: height.toDouble(),
                            min: 120.0,
                            max: 220.0,
                            activeColor: kBottomContainerColour,
                            inactiveColor: Colors.grey,
                            onChanged: (double newValue){
                              setState(() {
                                height = newValue.round();
                              });
                            },
                          )
                        ],
                      ),
                    )
                ),
                //Expanded(child: ReusableCard()),
              ],
            )),
            Expanded(child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: (){
                                    setState(() {
                                      weight--;
                                    });
                                  }
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: (){
                                    setState(() {
                                      weight++;
                                    });
                                  }
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: (){
                                  setState(() {
                                    age--;
                                  });
                                }
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: (){
                                  setState(() {
                                    age++;
                                  });
                                }
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ),
            BottomButton(buttonTitle: 'CALCULATE',
              onTap: (){
                CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return ResultPage(bmiResult: calc.calculateBMI(), resultText: calc.getResult(),);
                    },
                  ),
                );
              },
            )
          ],
        )
    );
  }
}