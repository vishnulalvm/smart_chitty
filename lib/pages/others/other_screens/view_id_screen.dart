import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewIdScreen extends StatelessWidget {
  final String path;
  const ViewIdScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: FileImage(
          File(path),
        ),
      ),
    );
  }
}
