import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int duration = 2;
  double button = 105;
  AnimationController _controller;
  AnimationController _controller2;
  var scaleAnimation;
  var scaleAnimation2;
  var translateAnimation;
  var transitionAnimation;
  var transitionAnimation2;
  var color_1 = Colors.redAccent;
  var color_2 = Colors.white;
  int phase = 1;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
        duration: new Duration(seconds: duration),
        vsync: this
    )
      ..addListener(() {
        setState(() {});
      });
    _controller.addStatusListener((status) {
      print(status);
      if(status == AnimationStatus.completed) {
        _controller2.forward();
        print(scaleAnimation2.value);
        setState(() {
          phase = 2;
        });
      }
    });
    scaleAnimation = new Tween(
      begin: 1.0,
      end: 200.0,
    ).animate(new CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInExpo
    ));

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );
    _controller2.addListener(() { setState(() {

    });});
    _controller2.addStatusListener((status) {
      print(status);
    });
    scaleAnimation2 = new Tween(
      begin: 200.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeOutCirc
    ));
    translateAnimation = new Tween(
      begin: 0.0,
      end: button*1.5,
    ).animate(new CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeOutExpo
    ));
    transitionAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeOutExpo
    ));
    transitionAnimation2 = new Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(new CurvedAnimation(
        parent: _controller2,
        curve: Curves.bounceOut
    ));



  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: phase == 1 ? color_2 : color_1,
      body: Stack(
        children: [
          phase == 1 ?
          Positioned(
            bottom: 100,
            left: size.width * 0.5 - button * 0.5 ,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context,_) {
                return Transform.scale(
                  origin: Offset(-button/2,0),
                  scale: scaleAnimation.value  ,
                  child: ClipOval(
                    child: InkWell(
                      onTap: () {
                        _controller.forward();
                      },
                      child: Container(
                        height: button,
                        width: button,
                        color: phase == 1 ? color_1 : color_2,
                        child: Center(
                          child: Icon(Icons.near_me,color: Colors.white,size: button/2,),
                        ),
                      ),
                    ),
                  ),
                );
              }
            )

          ) :
              Positioned(
                left: size.width * 0.5 - button*2,
                bottom: 100,
                child: AnimatedBuilder(
                  animation: _controller2,
                  builder: (context,_) {
                    return Transform.translate(
                      offset: Offset(translateAnimation.value,0),

                      child: Transform.scale(
                        origin: Offset(button/2,0),
                        scale: scaleAnimation2.value,
                        child: ClipOval(
                          child: Container(
                            height: button,
                            width: button,
                            color: phase == 1 ? color_1 : color_2,
                            child: Center(
                              child: Icon(
                                Icons.done,
                                size: button/2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ),
          Positioned(
            top: 300,
            left: size.width * 0.5 - 70,
            child: AnimatedBuilder(
              animation: _controller2,
              builder: (context,_) {
                return Transform.translate(
                  offset: Offset(0,-transitionAnimation2.value),
                  child: Text('Done',style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(transitionAnimation.value)
                  ),),
                );
              }
              ,
            ),
          )
        ],
      ),
    );
  }
}
