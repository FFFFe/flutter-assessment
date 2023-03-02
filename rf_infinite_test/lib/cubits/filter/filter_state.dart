// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_cubit.dart';

enum ContactFilter {
  all,
  favourite,
}

class FilterState extends Equatable {
  final ContactFilter contactFilter;

  const FilterState({
    required this.contactFilter,
  });

  factory FilterState.initial() {
    return const FilterState(contactFilter: ContactFilter.all);
  }

  @override
  List<Object> get props => [contactFilter];

  @override
  bool get stringify => true;

  FilterState copyWith({
    ContactFilter? contactFilter,
  }) {
    return FilterState(
      contactFilter: contactFilter ?? this.contactFilter,
    );
  }
}
