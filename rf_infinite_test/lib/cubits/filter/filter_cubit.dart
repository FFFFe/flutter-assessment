import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.initial());

  void changeFilter(ContactFilter filter) {
    emit(state.copyWith(contactFilter: filter));
  }
}
