import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/album_bloc.dart';
import '../viewmodels/album_state.dart';
import '../models/photo.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumBloc>().add(FetchAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            final albums = state.albums;
            final photos = state.photos;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                final photo = photos.firstWhere(
                  (p) => p.albumId == album.id,
                  orElse: () => Photo(
                    albumId: album.id,
                    id: 0,
                    title: 'No Photo',
                    url: '',
                    thumbnailUrl: '',
                  ),
                );
                return ListTile(
                    leading: Image.network(
                      'https://picsum.photos/seed/album/99',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(photo.title),    
                  onTap: () {
                    context.push('/album/${album.id}');
                  },
                );
              },
            );
          } 
          else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumBloc>().add(FetchAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Welcome! Tap to load albums.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AlbumBloc>().add(FetchAlbums());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}