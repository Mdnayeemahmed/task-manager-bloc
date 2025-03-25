import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerCubit() : super(ImagePickerInitial());

  Future<void> pickImage() async {
    emit(ImagePickerLoading());
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        print(image.path);
        emit(ImagePickerPicked(image));
      } else {
        // If the user cancels image picking, revert to initial state
        emit(ImagePickerInitial());
      }
    } catch (error) {
      emit(ImagePickerError(error.toString()));
    }
  }
}
