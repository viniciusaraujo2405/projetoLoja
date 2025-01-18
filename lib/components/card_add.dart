import 'package:flutter/material.dart';


class AdicionarCartaoPage extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;
  const AdicionarCartaoPage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AdicionarCartaoPageState createState() => _AdicionarCartaoPageState();
}
  class _AdicionarCartaoPageState extends State<AdicionarCartaoPage> {
    final _formKey = GlobalKey<FormState>();
    String? nome, numero, validade, cvv;

  void _salvarCartao() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.onSubmit({
        'nome': nome!,
        'numero': numero!,
        'validade': validade!,
        'cvv': cvv!,
      });
    }
  }
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adicionar Cartão")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => nome = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Número"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => numero = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Validade"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => validade = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "CVV"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => cvv = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarCartao,
                child: Text("Salvar"),
              )
            ]
          ),
        ),
      ),
    );
    }
  }