// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String searchTerm;
  const SearchState({
    required this.searchTerm,
  });

  factory SearchState.initial() {
    return const SearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  SearchState copyWith({
    String? searchTerm,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
