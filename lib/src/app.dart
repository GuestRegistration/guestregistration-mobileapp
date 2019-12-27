import 'package:flutter/material.dart';
import 'package:passwordless/src/auth_bloc_provider.dart';
import 'package:passwordless/src/auth_screen.dart';

class PasswordlessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthBlocProvider(
      child: MaterialApp(
          theme: new ThemeData(scaffoldBackgroundColor: const Color(0xff151232)),
        home: Scaffold(
          
          body: AuthScreen(),
        ),
      ),
    );
  }
}
