import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

// --- CLASE PRINCIPAL DE LA APP ---
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Formal',
      theme: ThemeData(
        // Tema oscuro para un look moderno y formal
        brightness: Brightness.dark, 
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: const Color(0xFF282C34), // Fondo oscuro
        useMaterial3: true,
      ),
      home: const Calculator(),
    );
  }
}

// --- LÓGICA DE LA CALCULADORA ---
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  // Función de la Lógica
  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      }
      _output += buttonText;
    } else if (buttonText == "=") {
      num2 = double.parse(_output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        // Manejo de la división por cero
        if (num2 == 0) {
          _output = "Error";
        } else {
          _output = (num1 / num2).toString();
        }
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      // Manejo de la entrada de números
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }

    // Limpia el resultado si termina en ".0"
    if (_output.endsWith(".0")) {
      _output = _output.substring(0, _output.length - 2);
    }
    
    // Si el resultado es demasiado largo, usa notación científica o recorta
    if (_output.length > 15) {
        _output = double.parse(_output).toStringAsPrecision(8);
    }

    setState(() {
      output = _output;
    });
  }

  // Widget para crear un botón moderno
  Widget buildButton(String buttonText, {Color color = Colors.blueGrey, Color textColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        child: MaterialButton(
          padding: const EdgeInsets.all(20.0),
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Esquinas redondeadas
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  // --- INTERFAZ DE USUARIO (UI) ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Estadística'),
        backgroundColor: const Color(0xFF21252B), // Barra de app más oscura
      ),
      body: Column(
        children: <Widget>[
          // Área de visualización del resultado
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          const Divider(color: Colors.white54, height: 1.0), // Separador elegante
          
          // Fila de botones
          Column(
            children: [
              // Fila 1: C, ÷
              Row(
                children: [
                  buildButton("C", color: Colors.red.shade700), // Botón C más visible
                  buildButton("÷", color: Colors.orange.shade700),
                ],
              ),
              // Fila 2: 7, 8, 9, ×
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("×", color: Colors.orange.shade700),
                ],
              ),
              // Fila 3: 4, 5, 6, -
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-", color: Colors.orange.shade700),
                ],
              ),
              // Fila 4: 1, 2, 3, +
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+", color: Colors.orange.shade700),
                ],
              ),
              // Fila 5: ., 0, =
              Row(
                children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("=", color: Colors.lightGreen.shade700, textColor: Colors.black), // Botón = que resalta
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}