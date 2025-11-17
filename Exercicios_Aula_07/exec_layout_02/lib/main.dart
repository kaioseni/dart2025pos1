import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double? temperatura;
  double? umidade;
  double? vento;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarClima();
  }

  Future<void> carregarClima() async {
    
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = pos.latitude;
    double lon = pos.longitude;

    String apiKey = "135f23f1bb7468fec91c9a28940f64d8";
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    var resposta = await http.get(Uri.parse(url));

    if (resposta.statusCode == 200) {
      var dados = jsonDecode(resposta.body);

      setState(() {
        temperatura = dados["main"]["temp"];
        umidade = dados["main"]["humidity"]?.toDouble();
        vento = dados["wind"]["speed"]?.toDouble();
        carregando = false;
      });
    } else {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: carregando
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Clima Atual",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    Text("Temperatura: ${temperatura ?? '--'} °C"),
                    Text("Umidade: ${umidade ?? '--'} %"),
                    Text("Velocidade do vento: ${vento ?? '--'} m/s"),
                  ],
                ),
        ),
      ),
    );
  }
}
