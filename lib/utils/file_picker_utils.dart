import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_selector/file_selector.dart';

class FilePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  /// Picks an image from the gallery (mobile) or file system (desktop/web)
  ///
  /// Returns:
  /// - `File` on Android/iOS/Desktop
  /// - `Uint8List` on Web
  /// - `null` if no file is picked
  static Future<dynamic> pickImage() async {
    try {
      if (kIsWeb) {
        final typeGroup = XTypeGroup(
          label: 'images',
          extensions: ['jpg', 'jpeg', 'png', 'gif'],
        );

        final file = await openFile(acceptedTypeGroups: [typeGroup]);
        if (file != null) {
          final bytes = await file.readAsBytes();
          return bytes; // Uint8List for web
        }
      } else if (Platform.isAndroid || Platform.isIOS) {
        final XFile? picked = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );
        if (picked != null) return File(picked.path);
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        final typeGroup = XTypeGroup(
          label: 'images',
          extensions: ['jpg', 'jpeg', 'png', 'gif'],
        );

        final file = await openFile(acceptedTypeGroups: [typeGroup]);
        if (file != null) return File(file.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    return null;
  }

  /// Deletes the selected image file or clears the reference
  ///
  /// Parameters:
  /// - `image`: the image object to delete (File or Uint8List)
  ///
  /// Returns:
  /// - `true` if deletion was successful
  /// - `false` if deletion failed or unsupported
  static Future<bool> deleteImage(dynamic image) async {
    try {
      if (kIsWeb) {
        // Web: just clear the reference (handled externally)
        return true;
      } else if (image is File && await image.exists()) {
        await image.delete();
        return true;
      }
    } catch (e) {
      debugPrint('Error deleting image: $e');
    }
    return false;
  }
}
