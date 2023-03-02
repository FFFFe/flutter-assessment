// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_profile_setting_cubit.dart';

enum ProfileSetting {
  view,
  edit;
}

class ContactProfileSettingState extends Equatable {
  final ProfileSetting profileSetting;
  const ContactProfileSettingState({
    required this.profileSetting,
  });

  factory ContactProfileSettingState.initial() {
    return ContactProfileSettingState(profileSetting: ProfileSetting.view);
  }

  @override
  List<Object> get props => [profileSetting];

  @override
  bool get stringify => true;

  ContactProfileSettingState copyWith({
    ProfileSetting? profileSetting,
  }) {
    return ContactProfileSettingState(
      profileSetting: profileSetting ?? this.profileSetting,
    );
  }
}
