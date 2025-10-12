import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductDetailScreen(),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              color: Colors.red[100],
              height: 250,
              width: double.infinity,
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 100,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              color: Colors.green[100],
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Air Max 270 React",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "\$150",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star_half, color: Colors.amber),
                      SizedBox(width: 8),
                      Text("4.7 (147 Reviews)"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue[100],
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Row(
                children: [
                  const Text(
                    "Select color: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Colors.purple, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Colors.yellow, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle)),
                ],
              ),
            ),
            Container(
              color: Colors.orange[100],
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Wrap(
                spacing: 8,
                children: List.generate(6, (index) {
                  final size = 7 + index;
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(size.toString()),
                  );
                }),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.purple[100],
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 200, 118, 214),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Add to Bag",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
