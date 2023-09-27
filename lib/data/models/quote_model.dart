import 'dart:convert';

QuoteModel quoteModelFromJson(String str) =>
    QuoteModel.fromJson(json.decode(str));

String quoteModelToJson(QuoteModel data) => json.encode(data.toJson());

class QuoteModel {
  final List<Quote> quotes;
  final int total;
  final int skip;
  final int limit;

  QuoteModel({
    required this.quotes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Quote {
  final int id;
  final String quote;
  final String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        quote: json["quote"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quote": quote,
        "author": author,
      };
}
