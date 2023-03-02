import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

part 'media_selector_state.dart';

class MediaSelectorCubit extends Cubit<MediaSelectorState> {
  final _picker = ImagePicker();
  MediaSelectorCubit() : super(MediaSelectorState.initial());

  Future<void> selectMedia(MediaType mediaType, ImageSource source) async {
    final XFile? media;
    if (mediaType == MediaType.image) {
      media = await _picker.pickImage(source: source);
    } else {
      media = await _picker.pickVideo(source: source);
    }
    if (media != null) {
      print('Media path: ${media.path}');
      emit(state.copyWith(media: media.path));
    }
  }

  // Future<void> selectMedia(MediaType mediaType, ImageSource source) async {
  //   File file = File('');
  //   final String? media;
  //   if (mediaType == MediaType.image) {
  //     media = await _picker.pickImage(source: source).then((image) {
  //       if (image != null) {
  //         file = File(image.path);
  //         return image.path;
  //       }
  //       return null;
  //     });
  //   } else {
  //     media = await _picker.pickVideo(source: source).then((video) {
  //       if (video != null) {
  //         file = File(video.path);
  //         return video.path;
  //       }
  //       return null;
  //     });
  //   }
  //   if (media != null) {
  //     String fileDir = path.dirname(media);
  //     String newPath = path.join(fileDir, 'newFileName.FileFormat');
  //     file.renameSync(newPath);
  //     emit(state.copyWith(mediaPath: file.path));
  //   }
  // }
}
