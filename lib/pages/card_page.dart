import 'package:flutter/material.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/card_add.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<Map<String, String>> cartoes = []; // Lista de cartões cadastrados.

  // Abre o formulário para adicionar um cartão.
  void _abrirFormularioCartao() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdicionarCartaoPage(onSubmit: _adicionarCartao),
      ),
    );
  }

  // Adiciona o cartão na lista e atualiza a tela.
  void _adicionarCartao(Map<String, String> cartao) {
    setState(() {
      cartoes.add(cartao); // Adiciona o novo cartão à lista.
    });

    // Exibe uma mensagem de sucesso.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cartão adicionado com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Cartões"),
        centerTitle: true,
      ),
      body: cartoes.isEmpty
          ? const Center(
              child: Text("Nenhum cartão cadastrado."),
            )
          : ListView.builder(
              itemCount: cartoes.length,
              itemBuilder: (context, index) {
                final cartao = cartoes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(cartao['nome'] ?? ''),
                    subtitle: Text(
                      '**** **** **** ${cartao['numero']?.substring(cartao['numero']!.length - 4)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          cartoes.removeAt(index); // Remove o cartão da lista.
                        });

                        // Exibe uma mensagem de remoção.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cartão removido.')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormularioCartao,
        child: const Icon(Icons.add),
      ),
      drawer: const AppDrawer(), // Menu lateral.
    );
  }
}
