import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieHeader extends StatelessWidget {
  final String imageUrl;

  const MovieHeader({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 16,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: Colors.grey[300]),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
