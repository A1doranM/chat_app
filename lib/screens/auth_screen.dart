import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(BuildContext ctx,
      {String email, String name, String password, bool isLogin}) async {
    AuthResult authResult;

    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (err) {
      String message = 'An error occured, please check credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(onSubmit: _submitAuthForm),
    );
  }
}