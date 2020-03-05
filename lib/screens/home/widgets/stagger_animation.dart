import 'package:animacoes_complexas_flare/screens/home/widgets/animated_list_view.dart';
import 'package:animacoes_complexas_flare/screens/home/widgets/fade_container.dart';
import 'package:animacoes_complexas_flare/screens/home/widgets/home_top.dart';
import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;

  StaggerAnimation({@required this.controller})
      : containerGrow = CurvedAnimation(
          //Para ter valor de 0 á 1 não deve passar o Tween
          parent: controller,
          curve: Curves.ease,
        ),
        listSlidePosition = EdgeInsetsTween(
          begin: EdgeInsets.only(bottom: 0),
          end: EdgeInsets.only(bottom: 80)
        ).animate(
            CurvedAnimation(
              parent: controller,
              curve: Interval(
                 0.325, //32,5% * 2 seconds
                 0.8, //80% * 2 seconds
                 curve: Curves.ease
              )
          )
       ),
       fadeAnimation = ColorTween(
         begin: Color.fromRGBO(247, 64, 106, 1.0),
         end: Color.fromRGBO(247, 64, 106, 0.0),
       ).animate(
         CurvedAnimation(parent: controller, curve: Curves.decelerate)
       );

  final Animation<double> containerGrow;
  final Animation<EdgeInsets> listSlidePosition;
  final Animation<Color> fadeAnimation;

  Widget _buildAnimation(BuildContext context, child) {
    return Stack(
      children: <Widget>[
        ListView( ///ListView já vem com Padding pré-configurado por isso tem que modificar
          padding: EdgeInsets.zero,///Para remover o afastamento nas laterais/bordas
          children: <Widget>[
            HomeTop(
              containerGrow: containerGrow,
            ),
            AnimatedListView(
              listSlidePosition: listSlidePosition,
            )
          ],
        ),
        IgnorePointer(//Tudo o que estiver como widget do child terá o ponteiro ignorado, ao clicar vai ignorar o ponteiro
          child: FadeContainer(
            fadeAnimation: fadeAnimation,
          ),
        ),
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
