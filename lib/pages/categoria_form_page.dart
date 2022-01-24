import 'package:flutter/material.dart';
import 'package:loja_completa/models/categoria.dart';
import 'package:loja_completa/models/categoria_lista.dart';
import 'package:provider/provider.dart';

class CategoriaFormPage extends StatefulWidget {
  const CategoriaFormPage({Key? key}) : super(key: key);

  @override
  _CategoriaFormPageState createState() => _CategoriaFormPageState();
}

class _CategoriaFormPageState extends State<CategoriaFormPage> {
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
        final categoria = arg as Categoria;
        formData['id'] = categoria.id;
        formData['name'] = categoria.name;
        formData['imageCat'] = categoria.imageCat;

        urlImageEC.text = categoria.imageCat;
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
      await Provider.of<CategoriaLista>(context, listen: false)
          .saveCategoria(formData);
      print('save>>>');
    } catch (e) {
      print(e);
      // await showDialog<void>(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: Text('Ocorreu um erro'),
      //     content: Text(
      //         'Algum erro inesperado ocorreu, aperte em OK e tente novamente mais tarde. $e'),
      //     actions: [
      //       TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('OK'))
      //     ],
      //   ),
      // );
    } finally {
      setState(() => isLoading = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Categoria'),
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
                      decoration:
                          InputDecoration(labelText: 'Nome da Categoria'),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'URL da Categoria'),
                            keyboardType: TextInputType.url,
                            focusNode: urlFocus,
                            controller: urlImageEC,
                            onSaved: (imageCat) =>
                                formData['imageCat'] = imageCat ?? '',
                            onFieldSubmitted: (_) => submitForm(),
                            validator: (_imageCat) {
                              final imageCat = _imageCat ?? '';
                              if (!isValidImageUrl(imageCat)) {
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
