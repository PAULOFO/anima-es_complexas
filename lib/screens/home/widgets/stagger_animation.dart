
import 'package:animacoes_complexas_flare/screens/home/widgets/home_top.dart';
import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {

  final AnimationController controller;

  StaggerAnimation({@required this.controller}) :
      containerGrow = CurvedAnimation(//Para ter valor de 0 á 1 não deve passar o Tween
          parent: controller,
          curve: Curves.ease,
      );

  final Animation<double> containerGrow;

  Widget _buildAnimation(BuildContext context, child) {
    return ListView(///ListView já vem com Padding pré-configurado por isso tem que modificar
      padding: EdgeInsets.zero,///Para remover o afastamento nas laterais/bordas
      children: <Widget>[
        HomeTop(
          containerGrow: containerGrow,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
            animation: controller,
            builder: _buildAnimation,
        ),
      ),
    );
  }
}

