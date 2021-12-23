import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_completa/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final urlFocus = FocusNode();
  final urlImageEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formData = Map<String, Object>();

  @override
  void initState() {
    urlImageEC.addListener(updateImage);
    super.initState();
  }

  void updateImage() {
    setState(() {});
  }

  void submitForm() {
    formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: formData['name'] as String,
      description: formData['description'] as String,
      price: formData['price'] as double,
      imageUrl: formData['urlProduct'] as String,
    );

    print(newProduct.id);
    print(newProduct.price);
    print(newProduct.name);
    print(newProduct.description);
    print(newProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario do Produto'),
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                textInputAction: TextInputAction.next,
                onSaved: (name) => formData['name'] = name ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (price) =>
                    formData['price'] = double.parse(price ?? '0'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição do Produto'),
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                onSaved: (description) =>
                    formData['description'] = description ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL do Produto'),
                      keyboardType: TextInputType.url,
                      focusNode: urlFocus,
                      controller: urlImageEC,
                      onSaved: (urlProduct) =>
                          formData['urlProduct'] = urlProduct ?? '',
                      onFieldSubmitted: (_) => submitForm(),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: urlImageEC.text.isEmpty
                        ? Text(
                            'Informa URL',
                          )
                        : FittedBox(
                            child: Image.network(
                              urlImageEC.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
