import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'movie_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IpModel ipModel = IpModel();
  MovieInfo movieInfo = MovieInfo();      //상태 저장
  TextEditingController textEditingController = TextEditingController();

  Future<void> _getIp() async {
    final dio = Dio();
    final client = RestClient(dio);

    ipModel = await client.getIp();
    setState(() {
    });
  }

  Future<void> _searchMovie() async {
    final dio = Dio();
    final client = MovieRestClient(dio);

    movieInfo = await client.getMovieInfo(textEditingController.text);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

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
              '${ipModel.origin}',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: textEditingController,
            ),
            GestureDetector(
              onTap: _searchMovie,
              child: Container(
                padding: EdgeInsets.all(20),
                color: Colors.green,
                child: Text("영화 검색"),
              ),
            ),
            Text("${movieInfo.id??""}"),
            Text("${movieInfo.name??""}"),
            Text("${movieInfo.language??""}"),
            Text("${movieInfo.runtime??""}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getIp,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
