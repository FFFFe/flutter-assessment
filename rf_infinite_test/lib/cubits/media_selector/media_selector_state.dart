// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'media_selector_cubit.dart';

enum MediaType {
  image,
  video;
}

class MediaSelectorState extends Equatable {
  final String media;
  const MediaSelectorState({
    required this.media,
  });

  factory MediaSelectorState.initial() {
    return const MediaSelectorState(media: '');
  }

  @override
  List<Object> get props => [media];

  @override
  bool get stringify => true;

  MediaSelectorState copyWith({
    String? media,
  }) {
    return MediaSelectorState(
      media: media ?? this.media,
    );
  }
}
