import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {

    List<Map<String,String>> cartoes = [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus cartões"),
      ),
      body: cartoes.isEmpty ? Center(
        child: Text("Nenhum cartão cadastrado."))
        : ListView.builder(
          itemCount: cartoes.length,
          itemBuilder:(context,index){
            final cartao = cartoes[index];
            return ListTile(
              title: Text(cartao['nome'] ?? ''),
              subtitle: Text('**** **** **** ${cartao['numero']?.substring(cartao['numero']!.length - 4)}'),
            );
          },
        ),
      ),
      );
    }
  }
