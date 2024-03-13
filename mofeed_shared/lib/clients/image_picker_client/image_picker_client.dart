import 'package:image_picker/image_picker.dart';
import 'package:mofeed_shared/model/app_file.dart';

import '../../utils/error/exceptions.dart';

class ImagePickerClient {
  final ImagePicker _imagePicker;

  const ImagePickerClient({
    required ImagePicker imagePicker,
  }) : _imagePicker = imagePicker;

  Future<AppFile?> pickUpImage() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      return pickedImage == null ? null : AppFile(pickedImage.path);
    } catch (e, st) {
      Error.throwWithStackTrace(PickupImageFailure(e), st);
    }
  }
}

class PickupImageFailure extends AppException {
  const PickupImageFailure(super.error);
}
