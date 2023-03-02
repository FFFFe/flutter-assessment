import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rf_infinite_test/models/contact.dart';

part 'current_selected_contact_state.dart';

class CurrentSelectedContactCubit extends Cubit<CurrentSelectedContactState> {
  CurrentSelectedContactCubit() : super(CurrentSelectedContactState.initial());

  void setCurrentSelectedContact(ContactList contact) {
    emit(state.copyWith(selectedContact: contact));
  }
}
