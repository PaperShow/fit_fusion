part of 'quote_bloc.dart';

sealed class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

final class QuoteInitial extends QuoteState {}

final class QuoteLoading extends QuoteState {}

final class QuoteLoaded extends QuoteState {
  final QuoteModel quotes;

  const QuoteLoaded({required this.quotes});

  @override
  List<Object> get props => [quotes];
}

final class QuoteError extends QuoteState {
  final String message;
  const QuoteError({required this.message});

  @override
  List<Object> get props => [message];
}
