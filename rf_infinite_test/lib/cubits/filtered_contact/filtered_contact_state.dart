// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_contact_cubit.dart';

class FilteredContactState extends Equatable {
  final List<ContactList> filteredContactList;
  const FilteredContactState({
    required this.filteredContactList,
  });

  factory FilteredContactState.initial() {
    return const FilteredContactState(filteredContactList: []);
  }

  @override
  List<Object> get props => [filteredContactList];

  @override
  bool get stringify => true;

  FilteredContactState copyWith({
    List<ContactList>? filteredContactList,
  }) {
    return FilteredContactState(
      filteredContactList: filteredContactList ?? this.filteredContactList,
    );
  }
}
