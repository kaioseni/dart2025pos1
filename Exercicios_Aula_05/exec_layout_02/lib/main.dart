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
  int contador = 0;
  double tamanhoFonte = 20;
  Color corBotao = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginaPrincipal(
        contador: contador,
        tamanhoFonte: tamanhoFonte,
        corBotao: corBotao,
        mudarContador: (valor) {
          setState(() {
            contador = valor;
          });
        },
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

class PaginaPrincipal extends StatelessWidget {
  final int contador;
  final double tamanhoFonte;
  final Color corBotao;
  final Function(int) mudarContador;
  final Function(double) mudarTamanhoFonte;
  final Function(Color) mudarCor;

  const PaginaPrincipal({
    super.key,
    required this.contador,
    required this.tamanhoFonte,
    required this.corBotao,
    required this.mudarContador,
    required this.mudarTamanhoFonte,
    required this.mudarCor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Drawer')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Configurações',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              title: Text('Ajustar contador'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaContador(
                      contador: contador,
                      mudarContador: mudarContador,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tamanho da fonte'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaFonte(
                      tamanhoFonte: tamanhoFonte,
                      mudarTamanhoFonte: mudarTamanhoFonte,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Cor'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaCor(
                      corBotao: corBotao,
                      mudarCor: mudarCor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Contador: $contador',
              style: TextStyle(fontSize: tamanhoFonte),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: corBotao),
              onPressed: () {
                mudarContador(contador + 1);
              },
              child: Text(
                'Aumentar contador',
                style: TextStyle(fontSize: tamanhoFonte),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaContador extends StatelessWidget {
  final int contador;
  final Function(int) mudarContador;

  const PaginaContador({
    super.key,
    required this.contador,
    required this.mudarContador,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajustar contador')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Valor atual: $contador'),
            ElevatedButton(
              onPressed: () {
                mudarContador(contador + 1);
                Navigator.pop(context);
              },
              child: Text('Aumentar'),
            ),
            ElevatedButton(
              onPressed: () {
                mudarContador(contador - 1);
                Navigator.pop(context);
              },
              child: Text('Diminuir'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaFonte extends StatelessWidget {
  final double tamanhoFonte;
  final Function(double) mudarTamanhoFonte;

  const PaginaFonte({
    super.key,
    required this.tamanhoFonte,
    required this.mudarTamanhoFonte,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tamanho da fonte')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Tamanho atual: ${tamanhoFonte.toStringAsFixed(0)}',
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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaCor extends StatelessWidget {
  final Color corBotao;
  final Function(Color) mudarCor;

  const PaginaCor({
    super.key,
    required this.corBotao,
    required this.mudarCor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escolher cor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Cor atual'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: corBotao),
              onPressed: () {},
              child: Text('Exemplo'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    mudarCor(Colors.blue);
                    Navigator.pop(context);
                  },
                  child: Container(width: 40, height: 40, color: Colors.blue),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    mudarCor(Colors.red);
                    Navigator.pop(context);
                  },
                  child: Container(width: 40, height: 40, color: Colors.red),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    mudarCor(Colors.green);
                    Navigator.pop(context);
                  },
                  child: Container(width: 40, height: 40, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
