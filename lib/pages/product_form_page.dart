import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final urlFocus = FocusNode();
  final urlImageEC = TextEditingController();

  @override
  void initState() {
    urlImageEC.addListener(updateImage);
    super.initState();
  }

  void updateImage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario do Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição do Produto'),
                keyboardType: TextInputType.multiline,
                maxLines: 6,
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
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: urlImageEC.text.isEmpty
                        ? Text(
                            'Informa URL',
                            textAlign: TextAlign.center,
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
