import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String maiorCotacao = '';
  String menorCotacao = '';
  String status = 'Clique em verificar para ver as cotações';

  Future<void> buscarCotacao() async {
    setState(() {
      status = 'Carregando...';
    });

    try {
      var url = Uri.parse('https://economia.awesomeapi.com.br/last/USD-BRL');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var dados = jsonDecode(response.body);
        var cotacao = dados['USDBRL'];

        setState(() {
          maiorCotacao = cotacao['high'];
          menorCotacao = cotacao['low'];
          status = 'Cotações atualizadas!';
        });
      } else {
        setState(() {
          status = 'Erro ao buscar dados (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        status = 'Erro na conexão: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cotação do Dólar'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  status,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: buscarCotacao,
                  child: const Text('Verificar'),
                ),
                const SizedBox(height: 30),
                if (maiorCotacao.isNotEmpty && menorCotacao.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        'Maior cotação: R\$ $maiorCotacao',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Menor cotação: R\$ $menorCotacao',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
