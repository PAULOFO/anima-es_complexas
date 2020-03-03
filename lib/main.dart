import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations Intro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: LogoApp(),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)///Ou milliseconds
    );

    //De 0 á 1 que demora 3 seconds
    //Qdo o valor for 0 vai valer 0
    //Qdo for 1 vale 300
    //Qdo for 0,5 vai valer 150
    animation = Tween<double>(begin: 0, end: 300).animate(controller);//Tween faz o mapeamento
    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();///forward Anima para frente //reverse anima para trás
  }

  @override
  void dispose() {
///dispose para não ficar consumundo recursos do app quando não utilizar essa tela
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation);
  }
}

class AnimatedLogo extends AnimatedWidget {

  AnimatedLogo(Animation<double> animation) : super (listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Center(
      child: Container(
        height: animation.value,//controller.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

///SingleTickerProviderStateMixin ->Informa todas as vezes que a tela for renderizada