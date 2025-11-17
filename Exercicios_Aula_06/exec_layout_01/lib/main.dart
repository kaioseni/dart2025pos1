import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

enum Operacoes { igual, sub, soma, div, multi }

class _CalculadoraState extends State<Calculadora> {
  String tela = '';
  String operando1 = '';
  String operando2 = '';
  Operacoes operador = Operacoes.igual;
  bool repetir = false;
  late var database;

  // memória da calculadora
  double memoria = 0.0;

  @override
  void initState() {
    super.initState();
    iniciaDB();
  }

  void iniciaDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = openDatabase(
      join(await getDatabasesPath(), 'dados.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE calculadora(id INTEGER PRIMARY KEY, tela TEXT)',
        );
        return db.execute(
          'INSERT INTO calculadora(id, tela) VALUES(1, "0")',
        );
      },
      version: 1,
    );
    iniciaTela();
  }

  void iniciaTela() async {
    var retornado = await retornaTela();
    setState(() {
      tela = retornado;
    });
  }

  Future<String> retornaTela() async {
    final db = await database;
    List<Map> lista = await db.rawQuery('SELECT * FROM calculadora');
    return lista[0]['tela'];
  }

  void salvaTela(String valor) async {
    final db = await database;
    int contador = await db.rawUpdate(
      'UPDATE calculadora SET tela = ? WHERE id = ?',
      [valor, 1],
    );
    print('updated: $contador');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                tela,
                style: TextStyle(
                  fontSize: 48,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),

            // BOTÕES AC, MRC, M+, M-
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tela = '';
                      });
                      salvaTela(tela);
                    },
                    child: Text('AC'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // MRC mostra a memória e limpa
                        tela = memoria.toString();
                        memoria = 0.0;
                      });
                      salvaTela(tela);
                    },
                    child: Text('MRC'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        double valorTela = double.tryParse(tela) ?? 0.0;
                        memoria = memoria + valorTela;
                      });
                    },
                    child: Text('M+'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        double valorTela = double.tryParse(tela) ?? 0.0;
                        memoria = memoria - valorTela;
                      });
                    },
                    child: Text('M-'),
                  ),
                ),
              ],
            ),

            // LINHA 1 → 7 8 9 /
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botaoNumero("7"),
                botaoNumero("8"),
                botaoNumero("9"),
                botaoOperacao('/', Operacoes.div),
              ],
            ),

            // LINHA 2 → 4 5 6 *
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botaoNumero("4"),
                botaoNumero("5"),
                botaoNumero("6"),
                botaoOperacao('*', Operacoes.multi),
              ],
            ),

            // LINHA 3 → 1 2 3 -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botaoNumero("1"),
                botaoNumero("2"),
                botaoNumero("3"),
                botaoOperacao('-', Operacoes.sub),
              ],
            ),

            // LINHA 4 → 0 . = +
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botaoZero(),
                botaoPonto(),
                botaoIgual(),
                botaoOperacao('+', Operacoes.soma),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // BOTÃO DE NÚMERO
  Widget botaoNumero(String numero) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (tela != '0') {
              tela += numero;
            } else {
              tela = numero;
            }
          });
          salvaTela(tela);
        },
        child: Text(numero),
      ),
    );
  }

  // BOTÃO ZERO
  Widget botaoZero() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (tela != '0') {
              tela += '0';
            }
          });
          salvaTela(tela);
        },
        child: Text('0'),
      ),
    );
  }

  // BOTÃO PONTO
  Widget botaoPonto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (!tela.contains('.')) {
            setState(() {
              tela += '.';
            });
            salvaTela(tela);
          }
        },
        child: Text('.'),
      ),
    );
  }

  // BOTÃO DE OPERAÇÃO
  Widget botaoOperacao(String simbolo, Operacoes op) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          operando1 = tela;
          tela = '';
          operador = op;
          repetir = false;
        },
        child: Text(simbolo),
      ),
    );
  }

  // BOTÃO IGUAL
  Widget botaoIgual() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (repetir) {
            operando1 = tela;
          } else {
            operando2 = tela;
          }

          if (operador == Operacoes.soma) {
            int resultado = int.parse(operando1) + int.parse(operando2);
            setState(() {
              tela = resultado.toString();
            });
          }

          if (operador == Operacoes.sub) {
            int resultado = int.parse(operando1) - int.parse(operando2);
            setState(() {
              tela = resultado.toString();
            });
          }

          if (operador == Operacoes.multi) {
            int resultado = int.parse(operando1) * int.parse(operando2);
            setState(() {
              tela = resultado.toString();
            });
          }

          if (operador == Operacoes.div) {
            if (!operando1.contains('.') && !operando2.contains('.')) {
              int op1 = int.parse(operando1);
              int op2 = int.parse(operando2);

              if (op1.remainder(op2) == 0) {
                setState(() {
                  tela = (op1 ~/ op2).toString();
                });
              } else {
                setState(() {
                  tela = (op1 / op2).toString();
                });
              }
            } else {
              double resultado =
                  double.parse(operando1) / double.parse(operando2);
              setState(() {
                tela = resultado.toString();
              });
            }
          }

          salvaTela(tela);
          repetir = true;
        },
        child: Text('='),
      ),
    );
  }
}
