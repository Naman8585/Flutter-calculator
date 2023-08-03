import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SIMPLE INTEREST CALCULATOR APP",
    home: SIForm(),
    theme: ThemeData(
      // useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.lightGreen,
      accentColor: Colors.lightGreen,
    ),
  ));
}

class SIForm extends StatefulWidget {
  const SIForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = 'Rupees';
  TextEditingController principalcontrolller = TextEditingController();
  TextEditingController roicontrolller = TextEditingController();
  TextEditingController termcontrolller = TextEditingController();

  var _displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("SIMPLE INTEREST CALCULATOR APP"),
      ),
      body: Form(
        key: _formkey,
          child: Padding(
        padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: [
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                style: textStyle,
                controller: principalcontrolller,
                validator: (var value){
                  if(value!.isEmpty){
                    return "please enter principal value";
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'enter Principal e.g. 12000',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextField(
                style: textStyle,
                controller: roicontrolller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'In Percent',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: termcontrolller,
                      style: textStyle,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Container(
                    width: _minimumPadding * 5.0,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies
                          .map(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      value: _currentItemSelected,
                      onChanged: (var newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen),
                    child: Text("Calculate",
                        style: textStyle, textScaleFactor: 1.2),
                    onPressed: () {
                      setState(() {
                        if(_formkey.currentState!.validate())
                        this._displayResult = _calculateTotalReturns();
                      });
                    },
                  )),
                  Container(
                    width: _minimumPadding * 5.0,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen),
                    child: Text(
                      "Reset",
                      style: textStyle,
                      textScaleFactor: 1.2,
                    ),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                  )),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(_minimumPadding * 2.0),
                child: Text(
                  this._displayResult,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = const AssetImage('images/moneyy.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      padding: EdgeInsets.all(_minimumPadding * 10),
      child: image,
    );
  }

  void _onDropDownItemSelected(newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalcontrolller.text);
    double roi = double.parse(roicontrolller.text);
    double term = double.parse(termcontrolller.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalcontrolller.text = '';
    roicontrolller.text = '';
    termcontrolller.text = '';
    _displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
