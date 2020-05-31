import 'dart:convert';

import 'package:quote_app/appData/appData.dart';
import 'package:quote_app/model/Quote.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class MyScopedModel extends Model{

	//list of app components
	List<Quote> _quote = [];


  //bool method to show progress while loading data
	bool _isLoading = false;

  //get methods to get data
	List<Quote> get quote {
		return _quote;
	}


  bool get isLoading {
		return _isLoading;
	}


  //fetch quote methods
	void fetchQuote() async {
		_isLoading = true;
		notifyListeners();
		try {
			http.Response response = await http.get("https://type.fit/api/quotes");
			if (response.statusCode == 200 ||
					response.statusCode == 201) {
				final List<Quote> fetchedQuoteList = [];
				List<dynamic> responseBody =
						jsonDecode(response.body);
            print(response);
				responseBody?.forEach((dynamic quoteData) {
					final Quote quote = Quote(
							quoteData['text'],
							quoteData['author']);
					fetchedQuoteList.add(quote);
				});
				_quote = fetchedQuoteList;
			}
			_isLoading = false;
			notifyListeners();
		} catch (error) {
			print(error);
			_isLoading = false;
			notifyListeners();
		}
	}

}