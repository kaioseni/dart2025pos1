import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MainApp());
}

class Localizacao {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> pegaLocalizacaoAtual() async {
    LocationPermission permissao;

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = pos.latitude;
    longitude = pos.longitude;
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Localizacao local = Localizacao();
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    pegarLocal();
  }

  Future<void> pegarLocal() async {
    await local.pegaLocalizacaoAtual();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Busca Local',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              carregando
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        Text("Latitude: ${local.latitude}"),
                        Text("Longitude: ${local.longitude}"),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
