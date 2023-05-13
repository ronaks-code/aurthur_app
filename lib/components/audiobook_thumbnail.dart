import 'package:flutter/material.dart';

class AudiobookThumbnail extends StatelessWidget {
  final String title;
  final ImageProvider imageSource;
  final Function onPress;

  const AudiobookThumbnail({
    required this.title,
    required this.imageSource,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(      
      onTap: () => onPress(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,  
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageSource,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
