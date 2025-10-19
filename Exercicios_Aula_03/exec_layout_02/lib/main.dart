import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: 'Mini Zap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _mensagens = [];

  void _enviarMensagem() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _mensagens.add(texto);
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5DD), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Row(
          children: [
            CircleAvatar(radius: 15, backgroundColor: Colors.white),
            SizedBox(width: 8),
            Text('Nome', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(8),
              itemCount: _mensagens.length,
              itemBuilder: (context, index) {
                final mensagem = _mensagens[index];
                final isPar = index % 2 == 0;

                return Align(
                  alignment:
                      isPar ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isPar
                          ? const Color(0xFFE1FFC7) 
                          : Colors.white, 
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isPar
                            ? const Radius.circular(16)
                            : const Radius.circular(0),
                        bottomRight: isPar
                            ? const Radius.circular(0)
                            : const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Text(
                      mensagem,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma mensagem',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _enviarMensagem,
                  icon: const Icon(Icons.send, color: Color(0xFF075E54)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
