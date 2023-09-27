import 'package:equatable/equatable.dart';
import 'package:fit_fusion/data/models/quote_model.dart';
import 'package:fit_fusion/data/repository/quote_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository _quoteRepository;
  QuoteBloc(this._quoteRepository) : super(QuoteInitial()) {
    on<LoadQuotesEvent>(_loadQuotes);
  }

  _loadQuotes(LoadQuotesEvent event, Emitter<QuoteState> emit) async {
    try {
      final quotes = await _quoteRepository.getQuotes();
      emit(QuoteLoaded(quotes: quotes));
    } catch (e) {
      emit(QuoteError(message: e.toString()));
    }
  }
}
