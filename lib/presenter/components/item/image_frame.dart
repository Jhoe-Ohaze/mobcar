import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  final Uint8List? image;
  final VoidCallback? onTap;

  const ImageFrame({
    required this.image,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (image != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.memory(
                image!,
                fit: BoxFit.cover,
                width: 200.0,
                height: 200.0,
              ),
            ),
          ] else ...[
            Icon(
              Icons.camera_alt,
              color: Colors.grey.shade600,
            ),
          ],
          Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: InkWell(onTap: onTap),
            ),
          )
        ],
      ),
    );
  }
}
