import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_profile_setting_state.dart';

class ContactProfileSettingCubit extends Cubit<ContactProfileSettingState> {
  ContactProfileSettingCubit() : super(ContactProfileSettingState.initial());

  void changeProfileSetting(ProfileSetting profileSetting) {
    emit(state.copyWith(profileSetting: profileSetting));
  }
}
