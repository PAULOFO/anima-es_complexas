import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {

  final AnimationController controller;

  StaggerAnimation({this.controller}) :
    buttonSqueeze = Tween(
      begin: 320.0,//Largura inicial do botão
      end: 60.0    //Largura final do botão
    ).animate(
      CurvedAnimation(
        parent: controller, ///155 de 2 segundos 0.150
        curve: Interval(0.0, 0.150)//Intervalo que acontece a curva porcentagem da animação
      )
    ),
    buttonZoomOut = Tween(
      begin: 60.0,//Largura e altura do botão ao iniciar
      end: 1000.0,//1000 Para cobrir a tela inteira
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1, curve: Curves.bounceOut),
      )
    );

  final Animation<double> buttonSqueeze;//double porque vai animar a largura do botão
  final Animation<double> buttonZoomOut;

  Widget _buildAnimation(BuildContext context, Widget child){
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: InkWell(
        onTap: (){
          controller.forward();///Inicia a animação
        },
        child: Hero(
          tag: 'fade',
          child: buttonZoomOut.value <= 60 ?//Se o buttonZoomOut for menor que 60 retorna o Container
          Container(
              width: buttonSqueeze.value,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 64, 106, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))
              ),
              child: _buildInside(context)
          ) :
          Container(
            width: buttonZoomOut.value,
            height: buttonZoomOut.value,
            //alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromRGBO(247, 64, 106, 1.0),
                shape: buttonZoomOut.value < 500 ?
                BoxShape.circle : BoxShape.rectangle
            ),
            //child: _buildInside(context)
          ),
        )
      ),
    );
  }

  Widget _buildInside(BuildContext context) {
    if(buttonSqueeze.value > 75) { //Qdo a largura do botão for maior que 75 ao encolher
      return Text(
        'Sign in',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
