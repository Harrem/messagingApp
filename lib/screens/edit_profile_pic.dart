import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/user_profile_actions.dart';
import '../widgets/custom_widgets.dart';

class EditProfilePicPage extends StatelessWidget {
  const EditProfilePicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userActions = Provider.of<UserActions>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile Picture"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            OvalPicture(
                image: userActions.userData.profilePictureUrl.isNotEmpty
                    ? Image.network(userActions.userData.profilePictureUrl)
                    : null,
                size: 130),
            const Divider(),
            const Divider(),
            const Divider(),
            OutlinedButton(
              onPressed: () async {
                var file = await _getFromGallery();
                File? croppedFile;
                if (file != null) {
                  croppedFile = await _cropImage(file.path);
                }
                if (croppedFile != null) {
                  await userActions.updateProfilePicture(croppedFile);
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Canceled")));
                }
              },
              child: const Text("Choose"),
            ),
          ],
        ),
      ),
    );
  }

  /// Get from gallery
  Future<XFile?> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    return pickedFile;
  }

  /// Crop Image
  Future<File?> _cropImage(filePath) async {
    var croppedImage = await ImageCropper().cropImage(
      aspectRatioPresets: [CropAspectRatioPreset.square],
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      return File(croppedImage.path);
    }
    return null;
  }
}
