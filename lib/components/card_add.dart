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

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adicionar Cartão")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(),
        ),
      ),
    ),













}