import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String _resultado = '0';
  String _operacion = '';
  double _primerNumero = 0;
  bool _nuevaOperacion = true;

  @override
  Widget build(BuildContext context) {
    //  aca esta lo de Obtener las dimensiones de la pantalla
    final size = MediaQuery.of(context).size;
    // Calcular el tamaño de los botones (20% del ancho de la pantalla)
    final buttonSize = size.width * 0.2;

    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro característico de iOS
      appBar: AppBar(
        title: const Text('Calculadora', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Display del resultado
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _resultado,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w300, // Fuente más delgada estilo iOS
                color: Colors.white,
              ),
            ),
          ),
          // Botones de la calculadora
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('÷'),
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('×'),
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
                _buildButton('C'),
                _buildButton('0'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String texto) {
    // aca esta lo de Determinar el color del botón basado en el tipo
    Color buttonColor;
    Color textColor = Colors.white;

    if (texto == 'C') {
      buttonColor = const Color(
          0xFFA5A5A5); // Gris claro para Clear para que quede como ios
      textColor = Colors.black;
    } else if (texto == '+' ||
        texto == '-' ||
        texto == '×' ||
        texto == '÷' ||
        texto == '=') {
      buttonColor = const Color(
          0xFFFF9F0A); // Naranja para operadores para que quede como ios
    } else {
      buttonColor = const Color(
          0xFF333333); // Gris oscuro para números para que quede como ios
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const CircleBorder(), // Aca esta lo de Botones circulares
        padding: const EdgeInsets.all(24),
      ),
      onPressed: () => _onButtonPressed(texto),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 30,
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  void _onButtonPressed(String texto) {
    setState(() {
      if (texto == 'C') {
        _resultado = '0';
        _operacion = '';
        _primerNumero = 0;
        _nuevaOperacion = true;
      } else if (texto == '=' && _operacion.isNotEmpty) {
        double segundoNumero = double.parse(_resultado);
        switch (_operacion) {
          case '+':
            _resultado = (_primerNumero + segundoNumero).toString();
            break;
          case '-':
            _resultado = (_primerNumero - segundoNumero).toString();
            break;
          case '×':
            _resultado = (_primerNumero * segundoNumero).toString();
            break;
          case '÷':
            _resultado = (_primerNumero / segundoNumero)
                .toString(); // aca esta lo de la division pero si es el divisor 0 tira que es infinito, eso se puede cuadrad o algo
            break;
        }
        _operacion = '';
        _nuevaOperacion = true;
      } else if (texto == '+' || texto == '-' || texto == '×' || texto == '÷') {
        _primerNumero = double.parse(_resultado);
        _operacion = texto;
        _nuevaOperacion = true;
      } else {
        if (_nuevaOperacion) {
          _resultado = texto;
          _nuevaOperacion = false;
        } else {
          _resultado = _resultado + texto;
        }
      }
    });
  }
}
