import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(File?) onImageSelected;

  const ImagePickerWidget({Key? key, required this.onImageSelected})
    : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
      widget.onImageSelected(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image != null
            ? Image.file(_image!, height: 150, fit: BoxFit.cover)
            : SizedBox(),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text("Upload Image"),
        ),
      ],
    );
  }
}
