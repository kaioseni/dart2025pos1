import 'package:flutter/material.dart';

void main() => runApp(const Primeira());

class Primeira extends StatefulWidget {
  const Primeira({super.key});

  @override
  State<Primeira> createState() => _PrimeiraState();
}

class _PrimeiraState extends State<Primeira> {
  int contagem = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Widgets')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Valor: $contagem',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contagem++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Botão'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
