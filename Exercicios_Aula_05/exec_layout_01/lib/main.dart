import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  double tamanhoFonte = 20;
  Color corBotao = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginaConfig(
        tamanhoFonte: tamanhoFonte,
        corBotao: corBotao,
        mudarTamanhoFonte: (valor) {
          setState(() {
            tamanhoFonte = valor;
          });
        },
        mudarCor: (cor) {
          setState(() {
            corBotao = cor;
          });
        },
      ),
    );
  }
}

class PaginaConfig extends StatelessWidget {
  final double tamanhoFonte;
  final Color corBotao;
  final Function(double) mudarTamanhoFonte;
  final Function(Color) mudarCor;

  const PaginaConfig({
    super.key,
    required this.tamanhoFonte,
    required this.corBotao,
    required this.mudarTamanhoFonte,
    required this.mudarCor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Mudar tamanho da fonte',
              style: TextStyle(fontSize: tamanhoFonte),
            ),
            Slider(
              value: tamanhoFonte,
              min: 10,
              max: 40,
              onChanged: (valor) {
                mudarTamanhoFonte(valor);
              },
            ),
            Text(
              'Escolher cor dos botões',
              style: TextStyle(fontSize: tamanhoFonte),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    mudarCor(Colors.blue);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    mudarCor(Colors.red);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    mudarCor(Colors.green);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: corBotao,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaExemplo(
                      tamanhoFonte: tamanhoFonte,
                      corBotao: corBotao,
                    ),
                  ),
                );
              },
              child: Text(
                'Ver exemplo',
                style: TextStyle(fontSize: tamanhoFonte),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaExemplo extends StatelessWidget {
  final double tamanhoFonte;
  final Color corBotao;

  const PaginaExemplo({
    super.key,
    required this.tamanhoFonte,
    required this.corBotao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exemplo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Texto de exemplo',
              style: TextStyle(fontSize: tamanhoFonte),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: corBotao,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Voltar',
                style: TextStyle(fontSize: tamanhoFonte),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
