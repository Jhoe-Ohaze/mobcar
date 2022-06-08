import 'dart:async';

class LoginValidator {
  final validateUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (user, sink) {
      if (user.length > 3) {
        sink.add(user);
      } else {
        sink.addError("O nome de usuario deve conter ao menos 4 caracteres");
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 5) {
        sink.add(password);
      } else {
        sink.addError("A senha deve conter pelo menos 6 caracteres");
      }
    },
  );
}
