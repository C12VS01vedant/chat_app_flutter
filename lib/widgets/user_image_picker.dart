import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key, required this.onPickImage})
      : super(key: key);

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  Future<void> _pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedImage == null) {
        return;
      }

      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });

      widget.onPickImage(_pickedImageFile!);
    } catch (e) {
      print('Error picking image: $e');
      // Handle the error gracefully, show a message, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          child: _pickedImageFile == null
              ? const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                )
              : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
