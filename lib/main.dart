import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var items;
  String mainValue = 'Temperature';
  String temp1Value = 'Celsius';
  String temp2Value = 'Fahernheit';
  double temppoint = 0;

  TextEditingController firstController = TextEditingController();

  final List<String> mainitems = [
    'Temperature',
    'Time',
    'Measurement',
  ];

  final List<String> Tempitems = [
    'Celsius',
    'Fahernheit',
    'Kelvin',
  ];

  final List<String> UnselecetedTemp = [
    'Celsius',
    'Fahernheit',
    'Kelvin',
  ];

  void convert(value) {
    if (temp1Value == 'Celsius' && temp2Value == 'Fahernheit') {
      temppoint = (int.parse(value) * 1.8) + 32;
    } else if (temp1Value == 'Celsius' && temp2Value == 'Kelvin') {
      temppoint = (int.parse(value) + 273.15);
    } else if (temp1Value == 'Fahernheit' && temp2Value == 'Celsius') {
      temppoint = (int.parse(value) - 32) / 1.8;
    } else if (temp1Value == 'Fahernheit' && temp2Value == 'Kelvin') {
      temppoint = ((int.parse(value) - 32) / 1.8) + 273.15;
    } else if (temp1Value == 'Kelvin' && temp2Value == 'Celsius') {
      temppoint = (int.parse(value) - 273.15);
    } else if (temp1Value == 'Kelvin' && temp2Value == 'Fahernheit') {
      temppoint = ((int.parse(value) - 273.15) * 1.8) + 32;
    } else {
      temppoint = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Exchanger'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: DropdownButton2(
                buttonDecoration: BoxDecoration(
                  color: const Color.fromARGB(153, 138, 138, 138),
                  borderRadius: BorderRadius.circular(5),
                ),
                items: mainitems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
                value: mainValue,
                onChanged: (value) {
                  setState(() {
                    mainValue = value as String;
                  });
                },
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 60),
                buttonWidth: 300,
                itemHeight: 40,
                underline: const SizedBox(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: 300,
                  child: TextFormField(
                    controller: firstController,
                    decoration: const InputDecoration(
                        hintText: 'Enter your number !',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    onChanged: (value) {
                      setState(() {
                        convert(value);
                      });
                    },
                  ),
                ),
                DropdownButton2(
                  buttonDecoration: BoxDecoration(
                    color: const Color.fromARGB(153, 223, 222, 222),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: Tempitems.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )).toList(),
                  value: temp1Value,
                  onChanged: (value) {
                    temp1Value = value as String;
                    setState(() {
                      if (temp2Value == temp1Value) {
                        temp2Value = 'Kelvin';
                      }
                      convert(firstController.text);
                    });
                    // convert(firstController.text);
                  },
                  buttonHeight: 30,
                  buttonPadding: const EdgeInsets.only(left: 40),
                  buttonWidth: 140,
                  itemHeight: 40,
                  underline: const SizedBox(),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  height: 40,
                  width: 300,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(93, 158, 158, 158),
                    Color.fromARGB(103, 158, 158, 158),
                  ])),
                  child: Text('$temppoint'),
                ),
                DropdownButton2(
                  buttonDecoration: BoxDecoration(
                    color: const Color.fromARGB(153, 223, 222, 222),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: UnselecetedTemp.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )).toList(),
                  value: temp2Value,
                  onChanged: (value) {
                    temp2Value = value as String;
                    setState(() {
                      if (temp2Value == temp1Value) {
                        temp1Value = 'Celsius';
                      }
                      convert(firstController.text);
                    });
                  },
                  buttonHeight: 30,
                  buttonPadding: const EdgeInsets.only(left: 40),
                  buttonWidth: 140,
                  itemHeight: 40,
                  underline: const SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
