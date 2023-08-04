import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobcar/core/login_validator.dart';
import 'package:rxdart/rxdart.dart';

// ignore: constant_identifier_names
enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc with LoginValidator {
  //Controllers
  final _emailBehavior = BehaviorSubject<String>();
  final _passwordBehavior = BehaviorSubject<String>();
  final _stateBehavior = BehaviorSubject<LoginState>();

  //Validation Streams
  Stream<String> get emailOutput =>
      _emailBehavior.stream.transform(validateUser);
  Stream<String> get passwordOutput =>
      _passwordBehavior.stream.transform(validatePassword);
  Stream<LoginState> get stateOutput => _stateBehavior.stream;

  //Validations Combo
  Stream<bool> get canSubmit =>
      Rx.combineLatest2(emailOutput, passwordOutput, (a, b) => true);

  Function(String) get changeEmail => _emailBehavior.sink.add;
  Function(String) get changePassword => _passwordBehavior.sink.add;

  late StreamSubscription _streamSubscription;

  LoginBloc() {
    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (user) async {
        if (user != null) {
          _stateBehavior.add(LoginState.SUCCESS);
        } else {
          _stateBehavior.add(LoginState.IDLE);
        }
      },
    );
  }

  //Realiza o login
  void submit() {
    final String email = '${_emailBehavior.value}@example.com';
    final String password = _passwordBehavior.value;

    _stateBehavior.add(LoginState.LOADING);

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  void dispose() {
    _emailBehavior.close();
    _passwordBehavior.close();
    _stateBehavior.close();

    _streamSubscription.cancel();
  }
}
