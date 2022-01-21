import 'package:flutter/material.dart';
import 'package:loja_completa/utils/app_routes.dart';

enum AuthModo {
  Login,
  Cadastro,
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthModo _authModo = AuthModo.Login;
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLogin() => _authModo == AuthModo.Login;
  bool _isCadastro() => _authModo == AuthModo.Cadastro;
  Map<String, String> authData = {
    'email': '',
    'senha': '',
  };
  final senhaEC = TextEditingController();
  _submit() {
    final isValido = formKey.currentState?.validate() ?? false;

    if(!isValido){
      return;
    }

    setState(() => _isLoading = true);

formKey.currentState?.save();

if(_isLogin()){

}else{
  
}

    setState(() => _isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              end: Alignment.topLeft,
              begin: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(48, 2, 65, 1),
                Color.fromRGBO(160, 0, 221, 1),
              ],
            )),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Faça Login',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Card(
                    child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                onSaved: (email) =>
                                    authData['email'] = email ?? '',
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                                validator: (_email) {
                                  final email = _email ?? '';
                                  if (!email.contains('@')) {
                                    return 'Email Invalido';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (senha) =>
                                    authData['senha'] = senha ?? '',
                                controller: senhaEC,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                ),
                                validator: (_senha) {
                                  final senha = _senha ?? '';
                                  if (senha.length < 6) {
                                    return 'Senha Muito Curta';
                                  }
                                  if (senha.isEmpty) {
                                    return 'Senha não pode ser vasia';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if (_isCadastro())
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Repetir Senha',
                                  ),
                                  validator: _isLogin()
                                      ? null
                                      : (_repSenha) {
                                          final repSenha = _repSenha ?? '';
                                          if (repSenha != senhaEC.text) {
                                            return 'Senhas não conferem';
                                          }

                                          return null;
                                        },
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: _isLoading ? null : _submit,
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.purple,
                                          )
                                        : Text(
                                            _isLogin() ? 'ENTRAR' : 'CADASTRAR',
                                            style: TextStyle(fontSize: 18),
                                          )),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(_isLogin()
                                      ? 'Quero me Cadastrar'
                                      : 'Fazer Login')),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
              },
              icon: Icon(
                Icons.cancel,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
