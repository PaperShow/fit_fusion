part of 'quote_bloc.dart';

sealed class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object> get props => [];
}

final class LoadQuotesEvent extends QuoteEvent {}
