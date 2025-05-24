import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../logic/album_bloc.dart';
import '../../logic/album_event.dart';
import '../../logic/album_state.dart';
import '../../widgets/album_tile.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumBloc>().add(LoadAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final AlbumModel album = state.albums[index];
                final PhotoModel photo = state.photos.firstWhere(
                      (p) => p.albumId == album.id,
                  orElse: () => PhotoModel(
                    albumId: album.id,
                    id: album.id,
                    title: '',
                    url: '',
                    thumbnailUrl: '',
                  ),
                );
                return AlbumTile(
                  title: album.title,
                  thumbnailUrl: photo.safeThumbnailUrl, // ✅ Use safe version
                  onTap: () {
                    context.push('/album/${album.id}');
                  },
                );
              },
            );
          }

          return const SizedBox(); // Fallback
        },
      ),
    );
  }
}
