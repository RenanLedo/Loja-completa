import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_completa/models/product.dart';
import 'package:loja_completa/models/product_list.dart';
import 'package:provider/provider.dart';

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

  bool isLoading = false;

  @override
  void initState() {
    urlImageEC.addListener(updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        formData['id'] = product.id;
        formData['name'] = product.name;
        formData['price'] = product.price;
        formData['description'] = product.description;
        formData['imageUrl'] = product.imageUrl;

        urlImageEC.text = product.imageUrl;
      }
    }
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool extensaoUrlValid = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && extensaoUrlValid;
  }

  Future<void> submitForm() async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    formKey.currentState?.save();
    setState(() => isLoading = true);

    try {
      await Provider.of<ProductList>(context, listen: false)
          .saveProduct(formData);
    } catch (e) {
     await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro'),
          content: Text(
              'Algum erro inesperado ocorreu, aperte em OK e tente novamente mais tarde.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        ),
      );
    } finally {
      setState(() => isLoading = false);
      Navigator.of(context).pop();
    }
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: formData['name']?.toString(),
                      decoration: InputDecoration(labelText: 'Nome do Produto'),
                      textInputAction: TextInputAction.next,
                      onSaved: (name) => formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'O campo não pode ser vasio';
                        }
                        if (name.length < 3) {
                          return 'O campo deve ter pelo menos 3 letras';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: formData['price']?.toString(),
                      decoration: InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSaved: (price) =>
                          formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: formData['description']?.toString(),
                      decoration:
                          InputDecoration(labelText: 'Descrição do Produto'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      onSaved: (description) =>
                          formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          return 'O campo não pode ser vasio';
                        }
                        if (description.length < 10) {
                          return 'O campo deve ter pelo menos 10 letras';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'URL do Produto'),
                            keyboardType: TextInputType.url,
                            focusNode: urlFocus,
                            controller: urlImageEC,
                            onSaved: (imageUrl) =>
                                formData['imageUrl'] = imageUrl ?? '',
                            onFieldSubmitted: (_) => submitForm(),
                            validator: (_imegeUrl) {
                              final imageUrl = _imegeUrl ?? '';
                              if (!isValidImageUrl(imageUrl)) {
                                return 'URL inválida, extensões válidas : PNG, JPG ou JPEG';
                              }
                              return null;
                            },
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
                              : Image.network(
                                  urlImageEC.text,
                                  fit: BoxFit.cover,
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
