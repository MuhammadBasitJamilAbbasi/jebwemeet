import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;
}
