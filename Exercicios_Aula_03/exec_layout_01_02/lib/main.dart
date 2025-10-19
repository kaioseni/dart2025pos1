import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ConsumoApp());
}

class ConsumoApp extends StatelessWidget {
  const ConsumoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo de Combustível',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const ConsumoScreen(),
    );
  }
}

class ConsumoScreen extends StatefulWidget {
  const ConsumoScreen({super.key});

  @override
  State<ConsumoScreen> createState() => _ConsumoScreenState();
}

class _ConsumoScreenState extends State<ConsumoScreen> {
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _litrosController = TextEditingController();
  final List<String> _resultados = [];

  void _calcularConsumo() {
    final double? km = double.tryParse(_kmController.text);
    final double? litros = double.tryParse(_litrosController.text);

    if (km == null || litros == null || litros == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe valores válidos')),
      );
      return;
    }

    final double consumo = km / litros;
    final String data = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final String resultado = '$data - ${consumo.toStringAsFixed(1)} km/l';

    setState(() {
      _resultados.insert(0, resultado); 
    });

    _kmController.clear();
    _litrosController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de Combustível'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _kmController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Km rodados',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _litrosController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Litros gastos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularConsumo,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _resultados.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.local_gas_station),
                      title: Text(_resultados[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
