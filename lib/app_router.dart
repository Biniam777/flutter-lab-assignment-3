import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/albums/presentation/pages/album_list_page.dart';
import 'features/albums/presentation/pages/album_detail_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListPage(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return AlbumDetailPage(albumId: id);
      },
    ),
  ],
);
