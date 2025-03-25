import 'package:image_picker/image_picker.dart';

// Abstract state for image picking
abstract class ImagePickerState {}

// Initial state when no image is picked
class ImagePickerInitial extends ImagePickerState {}

// Loading state while picking an image
class ImagePickerLoading extends ImagePickerState {}

// State when an image has been picked
class ImagePickerPicked extends ImagePickerState {
  final XFile image;
  ImagePickerPicked(this.image);
}

// Error state for any issues during image picking
class ImagePickerError extends ImagePickerState {
  final String message;
  ImagePickerError(this.message);
}
