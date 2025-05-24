import 'package:flutter/material.dart';

class AlbumTile extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final VoidCallback onTap;

  const AlbumTile({
    super.key,
    required this.title,
    required this.thumbnailUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: thumbnailUrl.isNotEmpty
          ? Image.network(thumbnailUrl, width: 50, height: 50)
          : const Icon(Icons.image_not_supported),
      title: Text(title),
      onTap: onTap,
    );
  }
}
