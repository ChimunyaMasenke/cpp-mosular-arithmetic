import 'package:flutter/material.dart';
import 'cpp_bridge.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _equation = "";
  String _displayText = "";
  late CppBridge _bridge;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    try {
      _bridge = CppBridge();
      _initialized = true;
    } catch (e) {
      debugPrint("Error initializing CppBridge: $e");
    }
  }

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _equation = "";
        _displayText = "";
      } else if (text == '=') {
        _calculate();
      } else if (text == 'Power') {
        _equation += "**";
      } else if (text == 'Factorial') {
        _calculateFactorial();
      } else {
        _equation += text;
      }
      _updateDisplay();
    });
  }

  void _updateDisplay() {
    // Regex to handle visual superscript for powers
    // 2**3 -> 2^{3}
    final regExp = RegExp(r"\*\*(\-?[\d\.]+)");
    _displayText = _equation.replaceAllMapped(regExp, (match) {
      return "^${match.group(1)}";
    });
    // In Flutter, we can use RichText for real superscripts, 
    // but for the basic display, we'll use ^ or a custom widget.
  }

  void _calculate() {
    if (!_initialized) return;
    try {
      final regExp = RegExp(r"(\-?[\d\.]+)\s*(\+|\-|\*|/|\*\*)\s*(\-?[\d\.]+)");
      final match = regExp.firstMatch(_equation);
      if (match == null) {
        _displayText = "Parse Error";
        return;
      }

      final a = double.parse(match.group(1)!);
      final op = match.group(2)!;
      final b = double.parse(match.group(3)!);
      double result = 0;

      switch (op) {
        case '+':
          result = _bridge.addition(a, b);
          break;
        case '-':
          result = _bridge.subtraction(a, b);
          break;
        case '*':
          result = _bridge.multiplication(a, b);
          break;
        case '/':
          if (b == 0) {
            _displayText = "Error (Div/0)";
            _equation = "";
            return;
          }
          result = _bridge.division(a, b);
          break;
        case '**':
          result = _bridge.power(a, b);
          break;
      }
      _equation = result.toString();
      _updateDisplay();
    } catch (e) {
      _displayText = "Error";
      _equation = "";
    }
  }

  void _calculateFactorial() {
    if (!_initialized) return;
    try {
      final num = int.parse(double.parse(_equation).toStringAsFixed(0));
      if (num < 0) {
        _displayText = "Error";
        _equation = "";
        return;
      }
      final result = _bridge.factorial(num);
      _equation = result.toString();
      _updateDisplay();
    } catch (e) {
      _displayText = "Error";
      _equation = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('C++ Powered Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: _buildRichDisplay(),
            ),
          ),
          _buildButtons(),
          _buildSpecialButtons(),
        ],
      ),
    );
  }

  Widget _buildRichDisplay() {
    // Custom rich text for superscripts
    final parts = _equation.split("**");
    if (parts.length < 2) {
      return Text(_equation, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold));
    }

    final base = parts[0];
    final exponent = parts[1];

    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
        children: [
          TextSpan(text: base),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Text(exponent, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    final buttons = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['0', 'C', '=', '+'],
    ];

    return Column(
      children: buttons.map((row) {
        return Row(
          children: row.map((text) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () => _onPressed(text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(text, style: const TextStyle(fontSize: 24)),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildSpecialButtons() {
    return Row(
      children: [
        _buildSpecialButton('Power'),
        _buildSpecialButton('Factorial'),
      ],
    );
  }

  Widget _buildSpecialButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(text, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
