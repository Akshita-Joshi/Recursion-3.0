import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

chooseImage() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
  );
}

uploadImageToStorage(PickedFile? pickedFile) async {
  if (kIsWeb) {
    Reference _reference = _firebaseStorage
        .ref()
        .child('images/${Path.basename(pickedFile!.path)}');
    await _reference
        .putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) {
        uploadedPhotoUrl = value;
      });
    });
  } else {
//write a code for android or ios
  }
}
