import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc2/quote_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteBloc>(
      create: (context) => QuoteBloc(),
      child: MaterialApp(
        title: "Bloc Demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: "Home",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuoteBloc>(context).add(Fetchdata());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              child: BlocBuilder<QuoteBloc, QuoteState>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: state.quoteslist.length,
                      itemBuilder: (BuildContext context,int index){
                        return ListTile(
                          leading: Text('${state.quoteslist[index].id}'),
                          title: Text('${state.quoteslist[index].quote}'),
                          subtitle: Text('${state.quoteslist[index].author}'),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}