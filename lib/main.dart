import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int initSecond, initMinute;
  late int _counterSecond;
  String secondString = '00', minuteString = '00', hourString = '00';
  late Timer timerDown;

  void resetTimer() {
    setState(() {
      timerDown.cancel();
      _counterSecond = initSecond;
      secondString = _counterSecond.toString();
    });
  }

  void pauseTimer() {
    setState(() {
      timerDown.cancel();
    });
  }

  void manageClock() {
    if (initSecond > 60) {
      initMinute += (initSecond / 60) as int;
      initSecond %= 60;

    }
  }

  void decrementCounter(){
    setState(() {
      _counterSecond--;
    });
    if(_counterSecond <= 0){
      timerDown.cancel();
    }
  }

  void resumeTimer() {
    timerDown = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        decrementCounter();
        if (_counterSecond <= 0) {
          timer.cancel();
        }
        if (_counterSecond < 10) {
          secondString = '0$_counterSecond';
        }
        else {
          secondString = _counterSecond.toString();
        }
      });
    });
  }

  @override
  void initState() {
    initSecond = 15;
    _counterSecond = initSecond;
    secondString = _counterSecond.toString();
    resumeTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  '00:00:$secondString',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 8,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[200],
                      ),
                      child: const Icon(
                        Icons.play_arrow_sharp,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        resumeTimer();
                      },
                    ),
                    Spacer(flex: 1,),
                    if(_counterSecond != initSecond || _counterSecond != 0)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[200],
                        ),
                        child: const Icon(
                          Icons.pause,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          pauseTimer();
                        },
                      ),
                    if(_counterSecond != initSecond || _counterSecond != 0)
                      Spacer(flex: 1,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Icon(
                        Icons.replay,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        resetTimer();
                      },
                    ),
                    Spacer(flex: 8,),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
