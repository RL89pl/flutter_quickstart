import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: BillSplitter()));
}

class HelloWorld extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("HelloWorld",
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Colors.red, fontSize: 24))
    );
  }
}

class BillSplitter extends StatefulWidget {

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  final _mainColor = Colors.grey.shade500;
  final _textStyle = TextStyle(
      color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 20);
  final _buttonStyle = TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);

  var _billValue = 0.0;
  var _numberOfPersons = 1;
  var _tipPercentage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kalkulator rachunku"), centerTitle: true,),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: _mainColor.withOpacity(0.4))),
                child: Column(
                  children: [
                    TextField(controller: TextEditingController(
                        text: _billValue.toString()),
                      style: _textStyle,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true),
                      decoration: InputDecoration(labelText: "Rachunek"),
                      onChanged: _onBillValueChanged,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ilość osób:", style: _textStyle),
                        Row(children: [
                          InkWell(
                            onTap: _onRemovePerson,
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: _mainColor, borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text("-", style: _buttonStyle),
                              ),
                            )
                          ),
                          Text("$_numberOfPersons", style: _textStyle),
                          InkWell(
                              onTap: _onAddPerson,
                              child: Container(
                                width: 30,
                                height: 30,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(color: _mainColor, borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text("+", style: _buttonStyle),
                                ),
                              )
                          ),
                        ],)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Napiwek:", style: _textStyle),
                        Padding(padding: EdgeInsets.all(10),
                          child: Text("${_totalTip().toStringAsFixed(2)} zł", style: _textStyle),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Slider(value: _tipPercentage.toDouble(),
                        onChanged: _onTipPercentageChange,
                        min: 0,
                        max: 100,
                        divisions: 20,
                        activeColor: Colors.blue.shade300,
                        ),
                        Text("$_tipPercentage %", style: _textStyle)
                      ],
                    )
                  ],
                )
            ),
            SizedBox(height: 20),
            Center(
              child:Text("Kwota na osobę: ${((_totalTip() + _billValue) / _numberOfPersons).toStringAsFixed(2)} zł",
                style: TextStyle(color: Colors.blue.shade300, fontWeight: FontWeight.bold, fontSize: 20),
              )
            )
          ],
        ),
      ),
    );
  }


  _onBillValueChanged(String value) {
    print(value);
    try {
      _billValue = double.parse(value);
    } catch (exception) {
      _billValue = 0;
    }
  }

  _onAddPerson() {
    setState(() => _numberOfPersons++);
  }

  _onRemovePerson() {
    if (_numberOfPersons > 0) {
      setState(() => _numberOfPersons--);
    }
  }

  double _totalTip(){
    return (_billValue * _tipPercentage) /100;
  }

  _onTipPercentageChange(double value) {
    setState(() => _tipPercentage = value.round());
  }
}