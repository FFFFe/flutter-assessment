import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  void searchContact(String searchTerm) {
    emit(state.copyWith(searchTerm: searchTerm));
  }
}
