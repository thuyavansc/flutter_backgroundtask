import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String text = "Stop Service";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: (){
                  FlutterBackgroundService().invoke('setAsForeground');
                },
                child: const Text('Foreground Service')
            ),
            ElevatedButton(
                onPressed: (){
                  FlutterBackgroundService().invoke('setAsBackground');
                },
                child: const Text('Background Service')
            ),
            ElevatedButton(
                onPressed: () async {
                  final service = FlutterBackgroundService();
                  bool isRunning =  await service.isRunning();

                  if(isRunning){
                    service.invoke('stopService');
                  } else{
                    service.startService();
                  }

                  if(!isRunning){
                    text = "Stop Service";

                  }else{
                    text = "Start Service";

                  }
                  setState(() {

                  });

                },
                child: Text('$text')
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}