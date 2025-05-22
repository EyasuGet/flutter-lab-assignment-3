import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/album_bloc.dart';
import '../viewmodels/album_state.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            final albums = state.albums;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  leading: Image.network(
                    'https://picsum.photos/seed/album/100', // Any static image URL
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(album.title),
                  onTap: () {
                    // Navigation or details logic here
                  },
                );
              },
            );
          } else if (state is AlbumError) {
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