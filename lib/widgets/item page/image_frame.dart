import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  final Stream<Uint8List?> stream;
  final Function() onTap;
  const ImageFrame({required this.stream, required this.onTap, Key? key})
      : super(key: key);

  final double size = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          StreamBuilder<Uint8List?>(
            stream: stream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        width: size,
                        height: size,
                      ),
                    )
                  : Icon(
                      Icons.camera_alt,
                      color: Colors.grey.shade600,
                    );
            },
          ),
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
