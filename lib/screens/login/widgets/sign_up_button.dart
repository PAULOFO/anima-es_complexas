import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(top: 160),
      onPressed: (){},
      child: Text(
          'Não possui uma conta? Cadastre-se!',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 14,
          letterSpacing: 0.5,///Afastamento das letras
        ),
      ),
    );
  }
}
