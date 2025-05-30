import 'package:flutter/material.dart';
import 'package:flutter_animations_showcase/pages/animated_builder_and_transform_page.dart';
import 'package:flutter_animations_showcase/pages/chained_animations_page.dart';

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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: ' Animations in Flutter'),
        '/AnimatedBuilderAndTransformPage': (context) =>
            const AnimatedBuilderAndTransformPage(),
        '/ChainedAnimationsPage': (context) => const ChainedAnimationsPage(),
      },
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/AnimatedBuilderAndTransformPage',
                );
              },
              child: Text("AnimatedBuilder and Transform"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ChainedAnimationsPage');
              },
              child: const Text("Chained Animations"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
