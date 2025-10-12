import 'package:flutter/material.dart';

void main() => runApp(const LojaApp());

class LojaApp extends StatelessWidget {
  const LojaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          title: const Text('NOVA'),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.purple[200],
              width: double.infinity,
              height: 180,
              child: const Center(
                child: Text(
                  'Banner / Destaque',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Container(
              color: Colors.blue[100],
              height: 60,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Men'),
                  Text('Woman'),
                  Text('Kids'),
                  Text('New'),
                  Text('Sale'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green[100],
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          height: 180,
                          color: Colors.orange[200],
                          child: const Center(child: Text('Produto 1')),
                        ),
                        Container(
                          width: 150,
                          height: 180,
                          color: Colors.orange[300],
                          child: const Center(child: Text('Produto 2')),
                        ),
                        Container(
                          width: 150,
                          height: 180,
                          color: Colors.orange[300],
                          child: const Center(child: Text('Produto 3')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          height: 180,
                          color: Colors.orange[400],
                          child: const Center(child: Text('Produto 4')),
                        ),
                        Container(
                          width: 150,
                          height: 180,
                          color: Colors.orange[500],
                          child: const Center(child: Text('Produto 5')),
                        ),
                        Container(
                          width: 150,
                          height: 180,
                          color: Colors.orange[300],
                          child: const Center(child: Text('Produto 6')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black87,
              width: double.infinity,
              height: 60,
              child: const Center(
                child: Text(
                  'Free Shipping Banner',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
