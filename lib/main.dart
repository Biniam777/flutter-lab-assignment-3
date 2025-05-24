import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/api_service.dart';
import 'features/albums/data/repositories/album_repository.dart';
import 'features/albums/logic/album_bloc.dart';
import 'features/albums/logic/album_event.dart';
import 'app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ApiService apiService = ApiService();
  late final AlbumRepository repository = AlbumRepository(apiService: apiService);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc(repository: repository)..add(LoadAlbums()),
      child: MaterialApp.router(
        title: 'Flutter Album Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
