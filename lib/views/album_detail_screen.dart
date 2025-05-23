import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/album_bloc.dart';
import '../viewmodels/album_state.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album Details')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumDetailLoaded) {
            final album = state.album;
            final photos = state.photos;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Album ID: ${album.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Title: ${album.title}', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 16),
                  const Text('Photos:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: photos.isEmpty
                        ? const Text('No photos found.')
                        : ListView.builder(
                            itemCount: photos.length,
                            itemBuilder: (context, index) {
                              final photo = photos[index];
                              return ListTile(
                                leading: Image.network(
                                  'https://picsum.photos/seed/album/101',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(photo.title),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          } else if (state is AlbumError) {
            return Center(child: Text(state.message));
          }
          // Fetch album details if not loaded yet
          context.read<AlbumBloc>().add(FetchAlbumDetail(albumId));
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}