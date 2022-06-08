import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobcar/core/database.dart';
import 'package:mobcar/core/login_bloc.dart';
import 'package:mobcar/pages/car_list_page.dart';
import 'package:mobcar/widgets/login_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.stateOutput.listen(
      (state) async {
        print(state);
        switch (state) {
          case LoginState.SUCCESS:
            await Database.setCarList();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const CarListPage()));
            break;
          case LoginState.FAIL:
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Erro'),
                content: Text('Usuario e/ou senha incorretos'),
              ),
            );
            break;
          default:
        }
      },
    );
  }

  Widget _loginPanel() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.9)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.home_filled,
            size: 120,
          ),
          const SizedBox(height: 30),
          LoginInputField(
            icon: Icons.person,
            label: 'Usuario',
            obscure: false,
            stream: _loginBloc.emailOutput,
            onChanged: _loginBloc.changeEmail,
          ),
          const SizedBox(height: 10),
          LoginInputField(
            icon: Icons.lock,
            label: 'Senha',
            obscure: true,
            stream: _loginBloc.passwordOutput,
            onChanged: _loginBloc.changePassword,
          ),
          const SizedBox(height: 20),
          StreamBuilder<bool>(
            stream: _loginBloc.canSubmit,
            builder: (context, snapshot) {
              return SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5);
                        } else {
                          return Theme.of(context).colorScheme.primary;
                        }
                      },
                    ),
                  ),
                  onPressed: snapshot.hasData ? _loginBloc.submit : null,
                  child: const Text('Entrar'),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Stack(
        alignment: Alignment.center,
        children: [Container(), SingleChildScrollView(child: _loginPanel())],
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: StreamBuilder<LoginState>(
          stream: _loginBloc.stateOutput,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.LOADING:
                return const Center(
                    child: CircularProgressIndicator(color: Colors.blue));
              case LoginState.IDLE:
                if (FirebaseAuth.instance.currentUser != null) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.blue));
                } else {
                  return body();
                }
              case LoginState.SUCCESS:
                return const Center(
                    child: CircularProgressIndicator(color: Colors.blue));
              default:
                return body();
            }
          },
        ),
      ),
    );
  }
}
