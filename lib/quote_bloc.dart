import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutterbloc2/Quotes.dart';

import 'RespMain.dart';
import 'package:http/http.dart' as http;

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  List<Quotes> list=[];
  QuoteBloc() : super(QuoteInitial(quoteslist: [])) {

    on<Fetchdata>((event, emit) {
      fetchquotes();
      emit(QuoteState(quoteslist: list));
    });
  }

  Future<List<Quotes>?> fetchquotes()  async {
    final response = await http.get(Uri.parse("https://dummyjson.com/quotes"));
    if (response.statusCode == 200) {
      var getquotesData = json.decode(response.body.toString());
      var res=RespMain.fromJson(getquotesData);
      list =res.quotes ;

      return list;
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}