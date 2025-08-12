import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: CalculatorApp(),
    );
  }
}

const Color colorDark = Color(0xff374352);
const Color colorLight = Color(0xffe6eeff);

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  bool darkMode = true;

  String expression = '';
  String result = '0';

  // Add character or operator to the expression
  void _addToExpression(String value) {
    setState(() {
      expression += value;
    });
  }

  // Clear expression and result
  void _clear() {
    setState(() {
      expression = '';
      result = '0';
    });
  }

  // Backspace last character
  void _backspace() {
    setState(() {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    });
  }

  // Calculate result using math_expressions package
  void _calculate() {
    try {
      String finalExpression = expression;
      // Replace custom operators for math_expressions
      finalExpression = finalExpression.replaceAll('x', '*');
      finalExpression = finalExpression.replaceAll('%', '/100');

      Parser p = Parser();
      Expression exp = p.parse(finalExpression);

      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            darkMode = !darkMode;
                          });
                        },
                        child: _switchMode(),
                      ),
                      const SizedBox(height: 80),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          result,
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: darkMode ? Colors.white : Colors.red,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '=',
                            style: TextStyle(
                              fontSize: 35,
                              color: darkMode ? Colors.green : Colors.grey,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              expression,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20,
                                color: darkMode ? Colors.green : Colors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonOval(title: 'sin', onTap: () => _addToExpression('sin(')),
                          _buttonOval(title: 'cos', onTap: () => _addToExpression('cos(')),
                          _buttonOval(title: 'tan', onTap: () => _addToExpression('tan(')),
                          _buttonOval(title: '%', onTap: () => _addToExpression('%')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(
                            title: 'C',
                            textColor: darkMode ? Colors.green : Colors.redAccent,
                            onTap: _clear,
                          ),
                          _buttonRounded(title: '(', onTap: () => _addToExpression('(')),
                          _buttonRounded(title: ')', onTap: () => _addToExpression(')')),
                          _buttonRounded(
                            title: '/',
                            textColor: darkMode ? Colors.green : Colors.redAccent,
                            onTap: () => _addToExpression('/'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '7', onTap: () => _addToExpression('7')),
                          _buttonRounded(title: '8', onTap: () => _addToExpression('8')),
                          _buttonRounded(title: '9', onTap: () => _addToExpression('9')),
                          _buttonRounded(
                            title: 'x',
                            textColor: darkMode ? Colors.green : Colors.redAccent,
                            onTap: () => _addToExpression('x'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '4', onTap: () => _addToExpression('4')),
                          _buttonRounded(title: '5', onTap: () => _addToExpression('5')),
                          _buttonRounded(title: '6', onTap: () => _addToExpression('6')),
                          _buttonRounded(
                            title: '-',
                            textColor: darkMode ? Colors.green : Colors.redAccent,
                            onTap: () => _addToExpression('-'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '1', onTap: () => _addToExpression('1')),
                          _buttonRounded(title: '2', onTap: () => _addToExpression('2')),
                          _buttonRounded(title: '3', onTap: () => _addToExpression('3')),
                          _buttonRounded(
                            title: '+',
                            textColor: darkMode ? Colors.green : Colors.redAccent,
                            onTap: () => _addToExpression('+'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '0', onTap: () => _addToExpression('0')),
                          _buttonRounded(title: '.', onTap: () => _addToExpression('.')),
                          _buttonRounded(
                            icon: Icons.backspace_outlined,
                            iconColor: darkMode ? Colors.green : Colors.red,
                            onTap: _backspace,
                          ),
                          _buttonRounded(
                            title: '=',
                            textColor: darkMode ? Colors.green : Colors.redAccent,
                            onTap: _calculate,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonRounded({
    String? title,
    double padding = 17,
    IconData? icon,
    Color? iconColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: AkContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(padding),
          child: Container(
            width: padding * 2,
            height: padding * 2,
            child: Center(
              child: title != null
                  ? Text(
                '$title',
                style: TextStyle(
                  color: textColor ??
                      (darkMode ? Colors.white : Colors.black),
                  fontSize: 30,
                ),
              )
                  : Icon(icon, color: iconColor, size: 30),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonOval({
    String? title,
    double padding = 17,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: AkContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(50),
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding / 2,
          ),
          child: Container(
            width: padding * 2,
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    return AkContainer(
      darkMode: darkMode,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.wb_sunny,
              color: darkMode ? Colors.grey : Colors.redAccent,
            ),
            Icon(
              Icons.nightlight_round,
              color: darkMode ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class AkContainer extends StatefulWidget {
  final bool darkMode;
  final Widget? child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  AkContainer({
    this.darkMode = false,
    this.child,
    this.borderRadius,
    this.padding,
  });

  @override
  State<AkContainer> createState() => _AkContainerState();
}

class _AkContainerState extends State<AkContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: darkMode ? colorDark : colorLight,
          borderRadius: widget.borderRadius,
          boxShadow: _isPressed
              ? null
              : [
            BoxShadow(
              color:
              darkMode ? Colors.black54 : Colors.blueGrey.shade200,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: darkMode ? Colors.blueGrey.shade700 : Colors.white,
              offset: const Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
