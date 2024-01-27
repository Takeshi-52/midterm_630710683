import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCal extends StatefulWidget {
  const MyCal({super.key});

  @override
  State<MyCal> createState() => _MyCalState();
}

class _MyCalState extends State<MyCal> {
  static const addSign = '\u002B';
  static const subtractSign = '\u2212';
  static const multiiplySign = '\u00D7';
  static const divideSign = '\u00F7';
  static const equalSign = '\u003D';
  static Color singColor = Color.fromARGB(255, 235, 235, 235);
  static Color numColor = Color.fromARGB(255, 255, 215, 215);

  String numOn = '';

  void addNum(String num) {
  setState(() {
    if (numOn.isNotEmpty && _isDigit(numOn[numOn.length - 1])) {
      numOn += num;
    } else if (numOn.isNotEmpty && _isOperator(numOn[numOn.length - 1]) && _isDigit(num)) {
      numOn += num;
    } else if (numOn.isNotEmpty && _isOperator(numOn[numOn.length - 1])) {
      numOn = numOn.substring(0, numOn.length - 1) + num;
    } else {
      numOn += num;
    }
  });
}

  bool _isDigit(String char) {
    return double.tryParse(char) != null;
  }

  bool _isOperator(String char){
    return char == addSign || char == subtractSign || char == multiiplySign || char == divideSign;
  }

  void removeNum() {
    setState(() {
      if (numOn.isNotEmpty) {
        numOn = numOn.substring(0, numOn.length - 1);
      }
    });
  }

  void clearNum() {
    setState(() {
      numOn = '';
    });
  }

  Widget display() {
    return Text(
      numOn.padLeft(1, '0'),
      style: GoogleFonts.roboto(
        fontSize: 60,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildNumButton(String num) {
    return InkWell(
      onTap: () {
        addNum(num);
      },
      child: Container(
        height: 115.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: numColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              num,
              style: GoogleFonts.roboto(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignButton(String sign){
    return InkWell(
      onTap: () {
        addNum(sign);
      },
      child: Container(
        height: 115.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: singColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sign,
              style: GoogleFonts.roboto(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clearButton() {
    return InkWell(
      onTap: clearNum,
      child: Container(
        height: 115.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: singColor,
        ),
        child: Text(
          'C',
          style: GoogleFonts.roboto(
            fontSize: 30.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget removerButton() {
    return InkWell(
      onTap: removeNum,
      child: Container(
        height: 115.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: singColor,
        ),
        child: Icon(
          Icons.backspace_outlined,
        ),
      ),
    );
  }

  Widget equalButton() {
    return InkWell(
      onTap: clearNum,
      child: Container(
        height: 115.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        child: Text(
          equalSign,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  Widget buildNumpad() {
    double size = 8.0;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: clearButton()),
              SizedBox(width: size),
              Expanded(child: removerButton()),
            ],
          ),
          SizedBox(height: size),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: buildNumButton('7')),
              SizedBox(width: size),
              Expanded(child: buildNumButton('8')),
              SizedBox(width: size),
              Expanded(child: buildNumButton('9')),
              SizedBox(width: size),
              Expanded(child: buildSignButton(divideSign)),
            ],
          ),
          SizedBox(height: size),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: buildNumButton('4')),
              SizedBox(width: size),
              Expanded(child: buildNumButton('5')),
              SizedBox(width: size),
              Expanded(child: buildNumButton('6')),
              SizedBox(width: size),
              Expanded(child: buildSignButton(multiiplySign)),
            ],
          ),
          SizedBox(height: size),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: buildNumButton('1')),
              SizedBox(width: size),
              Expanded(child: buildNumButton('2')),
              SizedBox(width: size),
              Expanded(child: buildNumButton('3')),
              SizedBox(width: size),
              Expanded(child: buildSignButton(subtractSign)),
            ],
          ),
          SizedBox(height: size),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: buildNumButton('0')),
              SizedBox(width: size),
              Expanded(child: buildSignButton(addSign)),
            ],
          ),
          SizedBox(height: size),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: equalButton()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              display(),
              buildNumpad(),
            ],
          ),
        ),
      ),
    );
  }
}
