import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../logic/album_bloc.dart';
import '../../logic/album_state.dart';

class AlbumDetailPage extends StatelessWidget {
  final int albumId;

  const AlbumDetailPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album Details')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoaded) {
            final AlbumModel album = state.albums.firstWhere(
                  (a) => a.id == albumId,
              orElse: () => AlbumModel(userId: 0, id: 0, title: 'Not Found'),
            );

            final List<PhotoModel> photos = state.photos
                .where((photo) => photo.albumId == albumId)
                .toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${album.title}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text('Photos:', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return Image.network(
                          photo.safeThumbnailUrl, // ✅ Use the CORS-safe version
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
