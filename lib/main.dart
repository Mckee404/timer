import 'dart:async';
import 'package:flutter/material.dart';

import 'next_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'タイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _second = 0;
  Timer? _timer;
  bool _isRunning=false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_second',
              style: TextStyle(fontSize: 64),
            ),
            ElevatedButton(onPressed: (){
              toggleTimer();
            }, 
            child: Text(_isRunning ? '停止':'開始'),
            ),
            ElevatedButton(onPressed: (){
              resetTimer();
            }, 
            child: Text('リセット'),
            ),
          ],
        ),
      ),
    );
  }

  void toggleTimer(){
    if(_isRunning){
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            _second++;
          });

          if(_second>=10){
            _timer?.cancel();
            _isRunning=false;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>NextPage()),
            );
          }
        },
      );
    }
    setState(() {
      _isRunning=!_isRunning;
    });

    
  }
  void resetTimer(){
      _timer?.cancel();
      setState(() {
        _second = 0;
        _isRunning = false;
    });
  }
}